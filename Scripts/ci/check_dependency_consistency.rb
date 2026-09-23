#!/usr/bin/env ruby
# frozen_string_literal: true

# Verifica se os xcframeworks declarados nos .podspec (CocoaPods) e no
# Package.swift (Swift Package Manager) estao consistentes entre si.
#
# Exemplo do problema que este script detecta: um .xcframework existe em
# Frameworks/ e e vendorizado por um .podspec (ex.: CertifaceFortface.xcframework
# usado pelo CertifaceSDK.podspec via CFFortfaceSDK), mas nao existe um
# binaryTarget correspondente no Package.swift -> consumidores via SPM
# ficam sem esse framework e o build quebra.

require 'json'
require 'open3'
require 'set'

ROOT = File.expand_path('../..', __dir__)
Dir.chdir(ROOT)

def run!(cmd)
  stdout, stderr, status = Open3.capture3(*cmd)
  unless status.success?
    warn "Comando falhou: #{cmd.join(' ')}"
    warn stderr
    exit 1
  end
  stdout
end

errors = []
warnings = []

# 1. Carrega todos os .podspec da raiz do repositorio ----------------------

podspec_files = Dir.glob('*.podspec').sort
if podspec_files.empty?
  warn 'Nenhum .podspec encontrado na raiz do repositorio.'
  exit 1
end

# 'Frameworks/X.xcframework' => ['CertifaceSDK.podspec', ...]
podspec_by_framework = Hash.new { |h, k| h[k] = [] }

podspec_files.each do |file|
  json = JSON.parse(run!(['pod', 'ipc', 'spec', file]))
  (json['vendored_frameworks'] || []).each do |fw_path|
    podspec_by_framework[fw_path] << file
  end
end

# 2. Carrega o Package.swift -------------------------------------------------

unless File.exist?('Package.swift')
  warn 'Package.swift nao encontrado na raiz do repositorio.'
  exit 1
end

package_json = JSON.parse(run!(%w[swift package dump-package]))

# 'Frameworks/X.xcframework' => 'NomeDoTarget'
binary_targets = {}
target_dependencies = Hash.new { |h, k| h[k] = [] }

package_json.fetch('targets', []).each do |target|
  name = target['name']

  deps = (target['dependencies'] || []).filter_map do |dep|
    dep['target']&.first || dep['byName']&.first
  end
  target_dependencies[name] = deps

  next unless target['type'] == 'binary'

  path = target['path']
  if path.nil? || !File.exist?(path)
    errors << "Package.swift: o binaryTarget '#{name}' aponta para '#{path}', que nao existe em disco."
    next
  end

  binary_targets[path] = name
end

# 3. xcframeworks presentes em disco -----------------------------------------

disk_frameworks = Dir.glob('Frameworks/*.xcframework').sort

# 4. Checagem cruzada: disco x podspecs x Package.swift ----------------------

disk_frameworks.each do |fw|
  pods = podspec_by_framework[fw]
  spm_target = binary_targets[fw]

  if pods.empty? && spm_target.nil?
    warnings << "'#{fw}' existe em Frameworks/, mas nao e referenciado por nenhum .podspec " \
                'nem pelo Package.swift. Framework orfao?'
    next
  end

  if !pods.empty? && spm_target.nil?
    errors << "'#{fw}' e vendorizado via CocoaPods em #{pods.join(', ')}, mas NAO existe um " \
              'binaryTarget correspondente no Package.swift. Consumidores via Swift Package ' \
              'Manager nao terao acesso a este framework (este e o tipo de problema que ' \
              'aconteceu com o CertifaceFortface/CFFortface).'
  end

  if pods.empty? && !spm_target.nil?
    warnings << "'#{fw}' tem um binaryTarget no Package.swift ('#{spm_target}'), mas nao e " \
                'vendorizado por nenhum .podspec. Confirme se isso e intencional.'
  end
end

# Sentido inverso: todo vendored_framework declarado precisa existir em disco.
podspec_by_framework.each do |fw, pods|
  next if File.exist?(fw)

  errors << "#{pods.join(', ')} declara vendored_frameworks '#{fw}', mas o arquivo/pasta nao " \
            'existe no repositorio.'
end

# 5. binaryTargets declarados mas inalcancaveis a partir de algum product ----

reachable = Set.new

collect_reachable = lambda do |name|
  return if reachable.include?(name)

  reachable << name
  target_dependencies[name].each { |dep| collect_reachable.call(dep) }
end

package_json.fetch('products', []).each do |product|
  (product['targets'] || []).each { |t| collect_reachable.call(t) }
end

binary_targets.each do |path, name|
  next if reachable.include?(name)

  warnings << "O binaryTarget '#{name}' (#{path}) esta declarado no Package.swift, mas nao e " \
              'alcancado por nenhum product (library). Ele fica invisivel para quem consome via SPM.'
end

# 6. Relatorio -----------------------------------------------------------------

puts '== Verificacao de consistencia: Podspecs x Package.swift =='
puts

if warnings.any?
  puts "Avisos (#{warnings.size}):"
  warnings.each { |w| puts "  - #{w}" }
  puts
end

if errors.any?
  puts "Erros (#{errors.size}):"
  errors.each { |e| puts "  - #{e}" }
  puts
  puts 'FALHOU: corrija as inconsistencias acima antes de mergear na main.'
  exit 1
end

puts 'OK: nenhuma inconsistencia critica encontrada entre os .podspec e o Package.swift.'

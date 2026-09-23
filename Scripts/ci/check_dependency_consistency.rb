#!/usr/bin/env ruby
# frozen_string_literal: true

# Checks whether the xcframeworks declared in the .podspec files (CocoaPods)
# and in Package.swift (Swift Package Manager) are consistent with each other.
#
# Example of the problem this script detects: an .xcframework exists in
# Frameworks/ and is vendored by a .podspec (e.g.: CertifaceFortface.xcframework
# used by CertifaceSDK.podspec via CFFortfaceSDK), but there is no
# corresponding binaryTarget in Package.swift -> consumers via SPM
# end up without that framework and the build breaks.

require 'json'
require 'open3'
require 'set'

ROOT = File.expand_path('../..', __dir__)
Dir.chdir(ROOT)

def run!(cmd)
  stdout, stderr, status = Open3.capture3(*cmd)
  unless status.success?
    warn "Command failed: #{cmd.join(' ')}"
    warn stderr
    exit 1
  end
  stdout
end

errors = []
warnings = []

# 1. Load all .podspec files from the repository root -----------------------

podspec_files = Dir.glob('*.podspec').sort
if podspec_files.empty?
  warn 'No .podspec found in the repository root.'
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

# 2. Load Package.swift -------------------------------------------------

unless File.exist?('Package.swift')
  warn 'Package.swift not found in the repository root.'
  exit 1
end

package_json = JSON.parse(run!(%w[swift package dump-package]))

# 'Frameworks/X.xcframework' => 'TargetName'
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
    errors << "Package.swift: binaryTarget '#{name}' points to '#{path}', which does not exist on disk."
    next
  end

  binary_targets[path] = name
end

# 3. xcframeworks present on disk --------------------------------------------

disk_frameworks = Dir.glob('Frameworks/*.xcframework').sort

# 4. Cross-check: disk x podspecs x Package.swift ----------------------------

disk_frameworks.each do |fw|
  pods = podspec_by_framework[fw]
  spm_target = binary_targets[fw]

  if pods.empty? && spm_target.nil?
    warnings << "'#{fw}' exists in Frameworks/, but is not referenced by any .podspec " \
                'nor by Package.swift. Orphan framework?'
    next
  end

  if !pods.empty? && spm_target.nil?
    errors << "'#{fw}' is vendored via CocoaPods in #{pods.join(', ')}, but there is NO " \
              'corresponding binaryTarget in Package.swift. Consumers via Swift Package ' \
              'Manager will not have access to this framework.'
  end

  if pods.empty? && !spm_target.nil?
    warnings << "'#{fw}' has a binaryTarget in Package.swift ('#{spm_target}'), but is not " \
                'vendored by any .podspec. Confirm whether this is intentional.'
  end
end

# Reverse direction: every declared vendored_framework must exist on disk.
podspec_by_framework.each do |fw, pods|
  next if File.exist?(fw)

  errors << "#{pods.join(', ')} declares vendored_frameworks '#{fw}', but the file/folder " \
            'does not exist in the repository.'
end

# 5. binaryTargets declared but unreachable from any product ----------------

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

  warnings << "binaryTarget '#{name}' (#{path}) is declared in Package.swift, but is not " \
              'reached by any product (library). It stays invisible to consumers via SPM.'
end

# 6. Report -----------------------------------------------------------------

puts '== Consistency check: Podspecs x Package.swift =='
puts

if warnings.any?
  puts "Warnings (#{warnings.size}):"
  warnings.each { |w| puts "  - #{w}" }
  puts
end

if errors.any?
  puts "Errors (#{errors.size}):"
  errors.each { |e| puts "  - #{e}" }
  puts
  puts 'FAILED: fix the inconsistencies above before merging into main.'
  exit 1
end

puts 'OK: no critical inconsistency found between the .podspec files and Package.swift.'

Pod::Spec.new do |s|
  s.name            = 'CertifaceDocSDK'
  s.version         = '0.1.0'
  s.summary         = 'Framework CertifaceDocSDK para iOS.'
  s.homepage        = 'https://www.oititec.com.br/'
  s.license         = { :type => 'Copyright', :text => 'Copyright © 2025 Oiti. All rights reserved.' }
  s.author          = 'Oititec'
  s.platform        = :ios, '13.0'
  s.swift_version   = '5.0'
  s.source          = { 
    :git => 'https://github.com/oititec/ios-modules-certiface.git', 
    :tag => s.name.to_s + '-' + s.version.to_s
  }
  s.vendored_frameworks = [
    'Frameworks/CertifaceDocSDK.xcframework'
  ]

  s.dependency 'CertifaceModules', '1.5.0'
end
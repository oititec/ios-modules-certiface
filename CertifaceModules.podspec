Pod::Spec.new do |s|
  s.name            = 'CertifaceModules'
  s.version         = '1.6.0'
  s.summary         = 'Certiface required modules'
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
    'Frameworks/CertifaceComponents.xcframework',
    'Frameworks/CertifaceUtils.xcframework',
    'Frameworks/CertifaceNetwork.xcframework',
    'Frameworks/CertifaceSecurity.xcframework'
  ]
end
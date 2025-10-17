Pod::Spec.new do |s|
  s.name            = 'CertifaceSDK'
  s.version         = '1.0.0'
  s.summary         = 'Framework CertifaceSDK para iOS.'
  s.homepage        = 'https://www.oititec.com.br/'
  s.license         = { :type => 'Copyright', :text => 'Copyright © 2025 Oiti. All rights reserved.' }
  s.author          = 'Oititec'
  s.platform        = :ios, '13.0'
  s.swift_version   = '5.0'
  s.source          = { 
    :git => 'https://github.com/oititec/ios-modules-oitisdk.git', 
    :tag => s.version.to_s 
  }
  s.vendored_frameworks = [
    'Frameworks/CertifaceComponents.xcframework',
    'Frameworks/CertifaceUtils.xcframework',
    'Frameworks/CertifaceNetwork.xcframework',
    'Frameworks/CertifaceSecurity.xcframework',
    'Frameworks/CertifaceIProov.xcframework',
    'Frameworks/CertifaceFacetec.xcframework',
    'Frameworks/CertifaceSDK.xcframework'
  ]

  s.dependency 'iProov', '12.3.1'
  s.dependency 'OILiveness3D_FT', '9.7.84'
end
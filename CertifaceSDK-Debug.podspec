Pod::Spec.new do |s|
  s.name            = 'CertifaceSDK'
  s.version         = '1.6.0'
  s.summary         = 'Framework CertifaceSDK para iOS.'
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
    'Frameworks/CertifaceIProov.xcframework',
    'Frameworks/CertifaceFacetec.xcframework',
    'Frameworks/CertifaceSDK.xcframework'
  ]

  s.dependency 'CertifaceModules', '1.6.0'
  s.dependency 'iProov', '12.5.0'
  s.dependency 'OILiveness3D_FT-Debug', '10.0.44'
end
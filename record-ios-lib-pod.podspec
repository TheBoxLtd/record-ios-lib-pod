
Pod::Spec.new do |s|
  s.name         = 'record-ios-lib-pod'
  s.version      = '1.0.0'
  s.summary      = 'Library for record voting app'
  s.homepage     = 'https://github.com/TheBoxLtd/record-ios-lib-pod'
  s.license      = { :type => 'BSD'}
  s.author    = 'Screenz Cross Media LTD.'
  s.source       = { :git => 'https://github.com/TheBoxLtd/record-ios-lib-pod.git', :tag => '1.0.0' }
  s.source_files  = 'TFLib/*'
  s.resources = 'TFLibResources/*'
  s.frameworks = 'CoreText.framework', 'SystemConfiguration.framework', 'MobileCoreServices.framework', 'UIKit.framework'
  s.dependency 'AFNetworking', 'SSKeychain'
end
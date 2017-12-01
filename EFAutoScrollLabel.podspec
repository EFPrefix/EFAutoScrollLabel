
Pod::Spec.new do |s|
  s.name             = 'EFAutoScrollLabel'
  s.version          = '4.0.2'
  s.summary          = 'A label which can scroll when text length beyond the width of label.'

  s.description      = <<-DESC
A label which can scroll when text length beyond the width of label, in Swift.
                       DESC

  s.homepage         = 'https://github.com/EyreFree/EFAutoScrollLabel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EyreFree' => 'eyrefree@eyrefree.org' }
  s.source           = { :git => 'https://github.com/EyreFree/EFAutoScrollLabel.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EyreFree777'

  s.ios.deployment_target = '8.0'

  s.source_files = 'EFAutoScrollLabel/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'EFAutoScrollLabel' => ['EFAutoScrollLabel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'Foundation', 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

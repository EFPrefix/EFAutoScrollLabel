Pod::Spec.new do |s|
    s.name             = 'EFAutoScrollLabel'
    s.version          = '5.1.0'
    s.summary          = 'A label which can scroll when text length beyond the width of label.'
    
    s.description      = <<-DESC
    A label which can scroll when text length beyond the width of label, in Swift.
    DESC
    
    s.homepage         = 'https://github.com/EFPrefix/EFAutoScrollLabel'
    s.screenshots      = 'https://raw.githubusercontent.com/EFPrefix/EFAutoScrollLabel/master/Assets/EFAutoScrollLabel.png'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'EyreFree' => 'eyrefree@eyrefree.org' }
    s.source           = { :git => 'https://github.com/EFPrefix/EFAutoScrollLabel.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/EyreFree777'
    
    s.ios.deployment_target = '8.0'
    s.requires_arc = true
    s.source_files = 'EFAutoScrollLabel/Classes/*.swift'
end

Pod::Spec.new do |s|
	s.name = 'JSQMessagesViewController-Skygear'
	s.module_name = 'JSQMessagesViewController'
	s.version = '7.3.5.4.4'
	s.summary = 'A fork of JSQMessagesViewController for use with SKYKitChat'
	s.homepage = 'https://skygear.io'
	s.license = 'MIT'
	s.platform = :ios, '7.0'

    s.author = { "Oursky Ltd." => "hello@oursky.com" }
    s.source = { :git => 'https://github.com/SkygearIO/JSQMessagesViewController.git',
                 :tag => s.version.to_s }
	s.source_files = 'JSQMessagesViewController/**/*.{h,m}'

	s.resources = ['JSQMessagesViewController/Assets/JSQMessagesAssets.bundle', 'JSQMessagesViewController/**/*.{xib}']

	s.frameworks = 'QuartzCore', 'CoreGraphics', 'CoreLocation', 'MapKit', 'AVFoundation'
	s.requires_arc = true

	s.dependency 'JSQSystemSoundPlayer', '~> 2.0.1'
end

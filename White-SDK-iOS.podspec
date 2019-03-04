#
# Be sure to run `pod lib lint White-SDK-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'White-SDK-iOS'
  s.version          = '2.0.0-beta2'
  s.summary          = 'White iOS端 SDK 仓库。'
  s.description      = <<-DESC
   White 白板，使用White SDK 创建自己的互动白板
                       DESC

  s.homepage         = 'https://github.com/duty-os/white-sdk-ios-release'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'white' => 'support@herewhite.com' }
  s.source           = { :git => 'https://github.com/duty-os/white-sdk-ios-release.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.vendored_libraries = 'White-SDK-iOS/libWhiteSDK.a'
  
  s.resource_bundles = {
    'WhiteSDK' => ['White-SDK-iOS/Resource/*']
  }

  s.source_files = 'White-SDK-iOS/Headers/*.h'
  s.frameworks = 'UIKit', 'WebKit'
  s.dependency 'dsBridge', '~> 3.0.2'
  s.dependency 'YYModel', '~> 1.0.4'
end

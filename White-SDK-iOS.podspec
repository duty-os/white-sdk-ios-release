#
# Be sure to run `pod lib lint White-SDK-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'White-SDK-iOS'
  s.version          = '0.2.1'
  s.summary          = 'A short description of White-SDK-iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/duty-os/White-SDK-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'white' => 'support@herewhite.com' }
  s.source           = { :git => 'https://github.com/duty-os/white-sdk-ios-release.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.vendored_libraries = 'White-SDK-iOS/libWhiteSDK.a'
  
  s.resource_bundles = {
    'WhiteSDK' => ['White-SDK-iOS/Resource/*']
  }

  s.source_files = 'White-SDK-iOS/Headers/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'dsBridge', '~> 3.0.2'
  s.dependency 'YYModel', '~> 1.0.4'
end

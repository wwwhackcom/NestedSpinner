#
# Be sure to run `pod lib lint NestedSpinner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NestedSpinner'
  s.version          = '1.0.3'
  s.summary          = 'A Customised Nested Spinner for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'A Customised Nested Spinner for iOS, which imitates implementation of Android Spinner.'
                       DESC

  s.homepage         = 'https://github.com/wwwhackcom/NestedSpinner'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NickWang' => 'wwwhackcom@qq.com' }
  s.source           = { :git => 'https://github.com/wwwhackcom/NestedSpinner.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'NestedSpinner/Classes/**/*'
  # s.resources = 'NestedSpinner/Assets/*.xcassets'
  
  s.swift_version = '5.0'
  s.platform = :ios, "9.0"
  
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  s.resource_bundles = {
    'NestedSpinner' => ['NestedSpinner/**/*.{xib,xcassets}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

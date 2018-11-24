#
# Be sure to run `pod lib lint NpageLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NpageLibrary'
  s.version          = '0.7.2'
  s.swift_version    = '4.0'
  s.summary          = 'This library is useful for Npage company.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Hi! This library is npage's private library!
More features will be added.
All Thanks!
                       DESC

  s.homepage         = 'http://git.npage.co.kr:8888/ho/npagelibraryios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ho' => 'ho@npage.co.kr' }
  s.source           = { :git => 'http://git.npage.co.kr:8888/ho/npagelibraryios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios
  s.ios.deployment_target = '9.0'

  s.source_files = 'NpageLibrary/Classes/**/*'
  
  #s.resource_bundles = {
      #'NpageLibrary' => ['NpageLibrary/Assets/*.png']
      #  'NpageLibrary' => ['NpageLibrary/Assets/*.*']
      #}
  
  s.resources = 'NpageLibrary/Assets/*.*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  # s.dependency 'Kingfisher', '~> 4.0'
  
end

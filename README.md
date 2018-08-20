# NpageLibary

<!--[![CI Status](https://img.shields.io/travis/ho/NpageLibrary.svg?style=flat)](https://travis-ci.org/npage-ho/npagelibraryios)-->
[![Version](https://img.shields.io/cocoapods/v/NpageLibrary.svg?style=flat)](https://cocoapods.org/pods/NpageLibrary)
[![License](https://img.shields.io/cocoapods/l/NpageLibrary.svg?style=flat)](https://cocoapods.org/pods/NpageLibrary)
[![Platform](https://img.shields.io/cocoapods/p/NpageLibrary.svg?style=flat)](https://cocoapods.org/pods/NpageLibrary)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

NpageLibrary is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NpageLibrary'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
        end
    end
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

```


## Author

ho, ho@npage.co.kr

## License

NpageLibary is available under the MIT license. See the LICENSE file for more info.

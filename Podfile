platform :ios, '9.0'

project 'Authenticator.xcodeproj'
target 'Authenticator' do

source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

# NB: get rid of next line once FMDB works with xcode 9
pod 'FMDB', :git => 'https://github.com/forcedotcom/fmdb', :branch => '2.7.2_xcode9'

pod 'SalesforceAnalytics', :path => 'mobile_sdk/SalesforceMobileSDK-iOS'
pod 'SalesforceSDKCore', :path => 'mobile_sdk/SalesforceMobileSDK-iOS'
pod 'SmartStore', :path => 'mobile_sdk/SalesforceMobileSDK-iOS'
pod 'SmartSync', :path => 'mobile_sdk/SalesforceMobileSDK-iOS'
pod 'SwipeCellKit'
pod 'Kingfisher', '~> 4.0'
pod 'WYPopoverController'
end

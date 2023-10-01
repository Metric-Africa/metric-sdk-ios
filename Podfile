# Uncomment the next line to define a global platform for your project

platform :ios, '15.0'

target 'MetricSDKExampleApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MetricSDKExampleApp
  pod 'MetricSDK', :podspec => 'https://raw.githubusercontent.com/Metric-Africa/metric-sdk-ios/main/MetricSDK.podspec'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end

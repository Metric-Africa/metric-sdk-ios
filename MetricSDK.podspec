 Pod::Spec.new do |s|
    s.name              = 'MetricSDK'
    s.version           = '1.0.48'
    s.summary           = 'Metric iOS SDK for Identity Verification'
    s.homepage          = 'https://github.com/Metric-Africa/metric-sdk-ios'

    s.author            = { 'Name' => 'Nii' }
    s.license           = { :type => 'Commercial', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :http => 'https://github.com/Metric-Africa/metric-sdk-ios/releases/download/v1.0.48/MetricSDK.zip' }

    s.ios.deployment_target = '15.0'
    s.swift_version = '5.5'

    #s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
    #s.user_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }

    s.dependency 'iProov', '~> 10.3.1'
    s.dependency 'OpenSSL-Universal', '~> 1.1.2200'
    s.dependency 'Starscream', '~> 4.0.4'
    s.dependency 'OZLivenessSDK', '~> 8.6.0'
   
    s.ios.vendored_frameworks = 'MetricSDK.xcframework','iProov.xcframework', 'OpenSSL.xcframework', 'Starscream.xcframework', 'OZLivenessSDK.xcframework'
end

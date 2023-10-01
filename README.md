# Metric SDK iOS
READING TIME: 4 MIN READ

## Introduction
The Metric iOS SDK enables you to integrate Metric into your iOS app. We also have an Android SDK[Insert Link], Web SDK[Insert Link].

### Sample App
We have a sample app that you can use to test the Metric iOS SDK. You can access it on GitHub through the following link: https://github.com/Metric-Africa/metric-sdk-ios

## Prerequisites
Make sure your system meets the following software requirements:
 - XCode 14+
- Swift 5.0+
- iOS 15+

## Installation via CocoaPods 
Integration with your app is supported via CocoaPods.

> The Metric iOS SDK is distributed as an XCFramework,
> therefore you are required
> to use CocoaPods 1.9.0 or newer.

1. If you are not yet using CocoaPods in your project, first run sudo gem install cocoapods. (For further information on installing CocoaPods, https://guides.cocoapods.org/using/getting-started.html#installation)
2.  Run `pod init` in your root directory of your project to create a Podfile.

2. Add the following to your Podfile (inside the target section):

```sh
pod 'MetricSDK', :podspec => 'https://raw.githubusercontent.com/Metric-Africa/metric-sdk-ios/main/MetricSDK.podspec'
```
3. Run `pod install`.

### Dependencies
The Metric iOS SDK has a dependency on 
[Starscream](https://github.com/daltoniam/Starscream). 
[OpenSSL-Universal](https://github.com/krzyzanowskim/OpenSSL). 

These dependencies will be automatically included via CocoaPods.


## XCode 14.0+ Error
There's a dynamic linking issue on  macOS/iOS for the newer XCode versions for certain dynamic frameworks. If you ever run into `dyld` error like below after running `pod install` and trying to run your project,

```sh
dyld[532]: Symbol not found: __ZN5swift34swift50override_conformsToProtocolEPKNS_14TargetMetadataINS_9InProcessEEEPKNS_24TargetProtocolDescriptorIS1_EEPFPKNS_18TargetWitnessTableIS1_EES4_S8_E
  Referenced from: <CF434E50-4753-32B1-BC49-77FF3D123A82> /private/var/containers/Bundle/Application/AD967DEA-F01C-4CC7-A8D3-00A0911EBBC0/SDKSample.app/Frameworks/iProov.framework/iProov
  Expected in:     <B8F7D7D2-01AE-35BF-B0B7-91D6488B6E35> /private/var/containers/Bundle/Application/AD967DEA-F01C-4CC7-A8D3-00A0911EBBC0/SDKSample.app/Frameworks/Starscream.framework/Starscream
```
put the following lines of code at the bottom of your `Podfile`.
```sh
...
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
...
```

and run the follwing commands 

 1. `pod deintegrate`
 2. `pod install`

## Initializing the SDK

1. First, import MetricSDK into your project within your AppDelegate class

```sh
...
import MetricSDK
...
```

2. Within your didFinishLaunchingWithOptions function, you can initialise your SDK with the .initialize functon.

```sh
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ...
        Metric.initialize(clientKey: "<Your client key here>",
                          secretKey: "<Your secret key here>")
     ...
    }
```

> To learn how to generate the clientKey and secretKey,
> kindly refer to this section of the documentation.
> https://docs.metric.africa/metric-for-developers/generate-id-and-secret-pair

### Permissions

###### Add an `NSCameraUsageDescription`

All iOS apps which require camera access must request permission from the user, and specify this information in the Info.plist.

Add an `NSCameraUsageDescription` entry to your app's Info.plist, with the reason why your app requires camera access (e.g. “To allow Metric Example App access your camera in order to verify your identity.”)

### Configuration and Customization
The `MetricSDKConfiguration` class is used to customise the look of the SDK such as colors and brand image. By default, your 
SDK environment is set to `Environment.sanbox`. Set to `Environment.production` when ready for release.
Call `MetricService.configure()` and pass in your configuration [Preferably in the `viewDidLoad()` of the `View Controller` that will launch the SDK] 

```sh
...
import MetricSDK
...
class ViewController: UIViewController {
    ...
    let config = MetricSDKConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        ...
        config.environment = Environment.sandbox
        config.brandLogoImageUrl = "htttps://example/image.png"
        config.brandPrimaryColor = "" //eg. #BBBBBB
        MetricService.configure(config)
        ...
    }
    ...
}
```
### Launch SDK
To launch the Metric SDK and initiate user verification, we would first need to generate a token. Information on token generation can be found here [https://docs.metric.africa/metric-for-developers/apis/generate-tokens]

After the token has been generated, you can launch the SDK like below:
 eg.
 
 ```sh
...
import MetricSDK
...
class ViewController: UIViewController {
    ...
    @objc private func launchSDKPressed(){
        let launcher = LaunchMetricSDK(token: "<token here>")
        launcher.modalPresentationStyle = .overCurrentContext
        launcher.modalTransitionStyle = .crossDissolve
        present(launcher, animated: true, completion:nil)
    }
    ...
}
```
 
 ### Listening for Results
 You can leverage MetricSDKs internal notification manager or use your own notification handler. Add a `NotificationCenter` observer to the `viewDidLoad()` of the view controller that launched your SDK. And pass in your @objc marked function as the selector. Eg. In this case we use `handleVerificationOutcome()`. You can call `deinit` but that's not really necessary if you're using Swift 4.2+.
 
 ```sh
...
import MetricSDK
...
class ViewController: UIViewController {
    ...
    override func viewDidLoad(){
        super.viewDidLoad()
        ...
        MetricNotificationManager.shared.addObserver(observer: self,
                                                     selector: #selector(handleVerificationOutcome),
                                                     name: NotificationKeys.VERIFICATION_COMPLETE)
    }
    ...
    
    @objc func handleVerificationOutcome(_ notification: Notification) {
    if let outcome = notification.object as? VerificationOutcome {
        switch outcome {
        case .success:
            //update your UI, etc..
            print("Verification Successful")
        case .failed(let reason):
            //update your UI, etc..
            print("Verification Failed due to: \(reason)")
        default:
            break
            }
        }
    }
}
```

In modern Swift, specifically from Swift 4.2 onwards, you generally do not need to manually remove observers for notifications, as they are automatically deregistered when the object is deallocated.

```sh
deinit{
     NotificationCenter.default.removeObserver(self, name: NotificationKeys.VERIFICATION_COMPLETE, object: nil)
}
```




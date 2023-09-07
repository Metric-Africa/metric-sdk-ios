# Metric SDK iOS

## Introduction
The Metric iOS SDK enables you to integrate Metric into your iOS app. We also have an Android SDK[Insert Link], Web SDK[Insert Link].

### Sample App
We have a sample app that you can use to test the Metric iOS SDK. You can access it on GitHub through the following link: https://github.com/Metric-Africa/metric-sdk-ios

### Prerequisites
Make sure your system meets the following software requirements:
 - XCode 14+
- Swift 5.0+
- iOS 15+

#### Installation via CocoaPods 
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

### Initializing the SDK

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
SDK envirenment is set to `Environment.sanbox`. Set to `Environment.production` when ready for release.
Call `MetricService.configure()` and pass in your configuration [Preferably in the `viewDidLoad` of the `ViewController` that will launch the SDK] 

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
        let launcher = LaunchSDK(token: "<token here>")
        launcher.modalPresentationStyle = .overCurrentContext
        launcher.modalTransitionStyle = .crossDissolve
        present(launcher, animated: true, completion:nil)
    }
    ...
}
```
 
 
 ### Listening for Results

# Metric SDK iOS

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
pod 'MetricSDK', '= <latest version>'
```
3. Run `pod install`.

### Dependencies
The Metric iOS SDK has a dependency on 
[Starscream](https://github.com/daltoniam/Starscream). 
[OpenSSL-Universal](https://github.com/krzyzanowskim/OpenSSL). 

These dependencies will be automatically included via CocoaPods.

 - Quit XCode and open the pod generated .xcworkspace file.

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
        config.environment = .sandbox
        config.brandLogoImageUrl = "htttps://example/image.png"
        config.brandPrimaryColor = "" //eg. #BBBBBB
        config.dataMode = .extended //optional | to return customer's name and unique id of the verification
        MetricService.configure(config)
       
        ...
    }
    ...
}
```

## Extra MetricSDK Information
There is a DataMode enum value[.basic, .extended] you can configure when initializing the SDK.
By default, this mode is .basic. If you need to view the verification transaction id, set this to .extended
and as part of your display, you will get this transaction id.
```
...
config.dataMode = .extended //default: .basic
...
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

 Handles the verification outcome broadcast by the system.

 - Note: By default, `VerificationOutcome.success` does not include customer data.
         If you set `config.dataMode = .extended`, you can access `customerName` and `suid` 
         from the `.success` payload.

 Usage:
 1. Set `config.dataMode = .extended` before starting the verification process.
 2. Observe the `Notification` containing the `VerificationOutcome`.
 3. Access the extended payload in the `.success` case.

 Example:
 ```swift
 @objc func handleVerificationOutcome(_ notification: Notification) {
     if let outcome = notification.object as? VerificationOutcome {
         switch outcome {
         case .success(let extendedData):
             // Extended data includes customerName and suid
             print("Verification successful for \(extendedData.customerName), suid: \(extendedData.suid)")
         case .failed(let reason):
             print("Session Failed: \(reason)")
         default:
             break
         }
     }
 }
```swift


> **Important**: If you do **not** set `config.dataMode = .extended`, the `.success` case will only indicate a successful verification, without the additional customer data.
```

In modern Swift, specifically from Swift 4.2 onwards, you generally do not need to manually remove observers for notifications, as they are automatically deregistered when the object is deallocated.

```sh
deinit{
     NotificationCenter.default.removeObserver(self, name: NotificationKeys.VERIFICATION_COMPLETE, object: nil)
}
```




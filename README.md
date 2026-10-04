# Metric SDK iOS

[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-brightgreen.svg?style=flat-square)](https://github.com/Metric-Africa/metric-sdk-ios)
[![Release](https://img.shields.io/github/v/release/Metric-Africa/metric-sdk-ios?style=flat-square)](https://github.com/Metric-Africa/metric-sdk-ios/releases)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/MetricSDK.svg?style=flat-square)](https://cocoapods.org/pods/MetricSDK)
[![Platform](https://img.shields.io/cocoapods/p/MetricSDK.svg?style=flat-square)](https://cocoapods.org/pods/MetricSDK)
[![Swift Version](https://img.shields.io/badge/Swift-5.9+-orange.svg?style=flat-square)](https://swift.org)

## Introduction
The **Metric iOS SDK** enables you to seamlessly integrate identity verification into your iOS applications. 

We also support the following platforms:
* **Android SDK**: [Android SDK Documentation](https://docs.metric.africa/metric-for-developers/sdks/android)
* **Web SDK**: [Web SDK Documentation](https://docs.metric.africa/metric-for-developers/sdks/web)

> [!TIP]
> **Looking for a quick start?** Explore our official [Metric iOS Sample App on GitHub](https://github.com/Metric-Africa/metric-sdk-ios) to see a complete integration in action.

---

## Prerequisites
Ensure your development environment meets the following software requirements:
* **Xcode**: 15.0+ (Swift Package Manager) / 14.0+ (CocoaPods)
* **Swift**: 5.9+ (Swift Package Manager) / 5.5+ (CocoaPods)
* **Minimum iOS Target**: iOS 15.0+ (Swift Package Manager) / iOS 13.0+ (CocoaPods)

---

## Installation via Swift Package Manager (SPM)
Integration is primarily supported and recommended via **Swift Package Manager**.

1. In Xcode, navigate to **File > Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/Metric-Africa/metric-sdk-ios.git`
3. Set the **Dependency Rule** to **Up to Next Major Version** with `1.2.2` (or choose **Exact Version** to pin a release), then click **Add Package**.
4. When prompted to choose package products, select **`MetricSDKSPM`** and add it to your app target.
5. Import the SDK in your code as `import MetricSDK`.

> [!NOTE]
> `MetricSDKSPM` is only the name of the package product shown in Xcode. Your code still uses `import MetricSDK`. The iProov and OZ Liveness dependencies are resolved and embedded automatically; no extra steps are needed.

---

## Installation via CocoaPods (Deprecated)
Integration is supported via **CocoaPods**.

> [!WARNING]
> **CocoaPods Sunset Notice:** CocoaPods has officially entered maintenance mode. The public registry will move to a permanent read-only state on **December 2, 2026**. We will phase out CocoaPods support from this SDK prior to that deadline. We strongly recommend migrating to **Swift Package Manager (SPM)** immediately.

> [!IMPORTANT]
> The Metric iOS SDK is distributed as a packaged binary (`XCFramework`), which requires **CocoaPods 1.9.0 or newer**.

1. If CocoaPods is not yet installed on your system, install it via terminal:
   ```bash
   sudo gem install cocoapods
   ```
   *(For more information, refer to the [CocoaPods Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html#installation))*

2. Initialize CocoaPods in your project's root directory:
   ```bash
   pod init
   ```

3. Open the newly generated `Podfile` and add the dependency inside your target section:
   ```ruby
   pod 'MetricSDK', '~> 1.1.0'
   ```

4. Run the installer:
   ```bash
   pod install
   ```

5. Close Xcode completely and open the generated **`.xcworkspace`** workspace file to begin coding.

### SDK Dependencies
The Metric iOS SDK depends on the following libraries:
* **[iProov](https://github.com/iproov/ios)** (Liveness Verification)
* **[OZLivenessSDK](https://github.com/ozforensics/oz-liveness-ios-sdk)** (Biometric Analysis)

> [!NOTE]
> These dependencies are automatically resolved, downloaded, and configured when you run `pod install`.

---

## Initializing the SDK

### 1. Import the SDK
Import `MetricSDK` into your app's entry point (e.g., `AppDelegate.swift`):

```swift
import UIKit
import MetricSDK
```

### 2. Initialize in App Launch
Within your `application(_:didFinishLaunchingWithOptions:)` function, initialize the SDK using your developer API credentials:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Initialize the SDK with client and secret keys
    Metric.initialize(
        clientKey: "<Your Client Key>",
        secretKey: "<Your Secret Key>"
    )
    
    return true
}
```

> [!TIP]
> To learn how to generate your developer `clientKey` and `secretKey`, refer to the [Metric API Credentials Guide](https://docs.metric.africa/metric-for-developers/generate-id-and-secret-pair).

---

## Permissions Configuration

### Camera Permission
All iOS apps requesting camera access must state their usage description in the application's `Info.plist`. 

Add the `NSCameraUsageDescription` key to your **`Info.plist`** with a clear explanation for the user:
```xml
<key>NSCameraUsageDescription</key>
<string>To allow Metric to access your camera in order to verify your identity.</string>
```

---

## Configuration and Customization

The `MetricSDKConfiguration` class allows you to tailor the look and behavior of the SDK to align with your brand. 

By default, the SDK runs in `Environment.sandbox`. Set it to `Environment.production` when transitioning to release.

Call `MetricService.configure(_:)` and pass in your configuration model (typically in the `viewDidLoad()` of the view controller launching the SDK):

```swift
import UIKit
import MetricSDK

class ViewController: UIViewController {

    let config = MetricSDKConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Set Environment (use .production for live environments)
        config.environment = .sandbox
        
        // 2. Customize Branding & Colors
        config.brandLogoImageUrl = "https://example.com/logo.png"
        config.brandPrimaryColor = "#000000" // Hex string representation
        
        // 3. Customize Data Mode
        // Set to .extended to retrieve customer's name and unique verification ID
        config.dataMode = .extended 
        
        // 4. Apply Configuration
        MetricService.configure(config)
    }
}
```

### Data Modes
The `DataMode` enum (`.basic`, `.extended`) governs what payload data is retrieved upon a successful verification:
* **`.basic`** (Default): Performs identity verification and flags success without returning personal identifiers.
* **`.extended`**: Returns the transaction unique ID (`suid`) and the customer's name.

---

## Launching the SDK

To start user verification, you must first generate an authentication token via the Metric API. Refer to the [Token Generation API Reference](https://docs.metric.africa/metric-for-developers/apis/generate-tokens) for details.

### SwiftUI Integration (iOS 13.0+)

The SDK provides a built-in `.metricVerification` view modifier for seamless SwiftUI integration. It handles presentation and outcome callbacks automatically.

```swift
import SwiftUI
import MetricSDK

struct ContentView: View {
    @State private var showVerification = false
    
    var body: some View {
        Button("Verify Identity") {
            showVerification = true
        }
        .metricVerification(isPresented: $showVerification, token: "<Generated Token>") { outcome in
            switch outcome {
            case .success(let payload):
                print("Verification successful! Details: \(payload)")
            case .failed(let reason):
                print("Verification failed: \(reason)")
            default:
                break
            }
        }
    }
}
```

### UIKit Integration

For UIKit applications, present the SDK launcher view controller:

```swift
import UIKit
import MetricSDK

class ViewController: UIViewController {

    @objc private func launchSDKPressed() {
        let launcher = LaunchMetricSDK(token: "<Generated Token>")
        launcher.modalPresentationStyle = .overCurrentContext
        launcher.modalTransitionStyle = .crossDissolve
        
        self.present(launcher, animated: true, completion: nil)
    }
}
```

---

## Handling Verification Outcomes

Listen to outcomes by registering a `NotificationCenter` observer in your View Controller.

### 1. Observe the Outcome
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(handleVerificationOutcome(_:)),
        name: Notification.Name(NotificationKeys.VERIFICATION_COMPLETE),
        object: nil
    )
}
```

### 2. Handle the Outcome Payload

> [!IMPORTANT]
> If `config.dataMode` is **not** set to `.extended`, the `.success` payload containing the customer data will be empty.

```swift
@objc func handleVerificationOutcome(_ notification: Notification) {
    guard let outcome = notification.object as? VerificationOutcome else { return }
    
    switch outcome {
    case .success(let payload):
        // payload holds customer details when config.dataMode = .extended
        print("Verification successful! Details: \(payload)")
        
    case .failed(let reason):
        print("Verification Session Failed: \(reason)")
        
    default:
        break
    }
}
```

> [!NOTE]
> For Swift 4.2+, manual removal of observers is handled automatically by the OS when the view controller is deallocated, making manual `deinit` cleanups optional.

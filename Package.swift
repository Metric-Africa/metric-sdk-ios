// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MetricSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MetricSDKSPM",
            type: .dynamic,
            targets: ["MetricSDKWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/iProov/ios.git", exact: "11.0.3"),
        .package(url: "https://gitlab.com/oz-forensics/oz-mobile-ios-sdk.git", exact: "8.7.0")
    ],
    targets: [
        .binaryTarget(
            name: "MetricSDK",
            url: "https://github.com/Metric-Africa/metric-sdk-ios/releases/download/v1.2.0/MetricSDK.zip",
            checksum: "a74d36a92ccc0a8314ce4312949ce15bea1e79c6f5bfaa612d762f9e243be2db"
        ),
        .target(
            name: "MetricSDKWrapper",
            dependencies: [
                .target(name: "MetricSDK"),
                .product(name: "iProov", package: "ios"),
                .product(name: "OZLivenessSDK", package: "oz-mobile-ios-sdk"),
                .product(name: "OZLivenessSDKOnDeviceResources", package: "oz-mobile-ios-sdk")
            ],
            path: "Sources/MetricSDKWrapper"
        )
    ]
)

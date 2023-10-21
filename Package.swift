// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MetricSDK",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "MetricSDK",
            targets: ["MetricSDKTargets"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "MetricSDK",
            url: "https://github.com/Metric-Africa/metric-sdk-ios/releases/download/v1.0.42/MetricSDK.zip",
            checksum: ""
        ),
        .target(
            name: "MetricSDKTargets",
            dependencies: [
                .target(name: "MetricSDK", condition: .when(platforms: .some([.iOS]))),
            ],
            path: "MetricSDKTargets"
        ),
    ]
)

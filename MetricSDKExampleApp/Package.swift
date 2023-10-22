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
            checksum: "0bb4ab502c84bc87117b38f74c626305d4479e7c3dbcf5194ee878d84b6cefc9"
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

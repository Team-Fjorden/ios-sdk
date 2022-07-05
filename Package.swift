// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "FjordenSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "FjordenSDK",
            targets: ["FjordenSDK"]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "FjordenSDK",
            url: "https://github.com/Team-Fjorden/ios-sdk/releases/download/v1.0.0-rc.1/FjordenSDK.xcframework.zip",
            checksum: "e490552f4f2255af46521578e1a7998bb6fa9a1c1f844d3554cbd0b554f2ce89"
        )
    ]
)

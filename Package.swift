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
            url: "https://github.com/Team-Fjorden/ios-sdk/releases/download/v1.0.0/FjordenSDK.xcframework.zip",
            checksum: "50aa6c8b47711dd47d4b7441e2ea9c5744a663c6527cd4678e9e4e8c3e3b20f8"
        )
    ]
)

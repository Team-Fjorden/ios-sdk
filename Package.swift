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
            url: "https://sdk.fjorden.co/releases/1.0.1/FjordenSDK.xcframework.zip",
            checksum: "67b9f3906e0a83021d4c31c5666bc8b773147a333bde15c2a8d0d1d2788ade45"
        )
    ]
)

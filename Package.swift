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
            url: "https://sdk.fjorden.co/releases/1.1.0/FjordenSDK.xcframework.zip",
            checksum: "1047c11174761a78f82ae67e3d009ea4602f6ad1ec5be226f9cf59f4662ed0a6"
        )
    ]
)

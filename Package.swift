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
            url: "https://sdk.fjorden.co/releases/1.1.2/FjordenSDK.xcframework.zip",
            checksum: "c3aa56331cc13da97678739aee2e7064d11683288910b3923db2c277a682b130"
        )
    ]
)

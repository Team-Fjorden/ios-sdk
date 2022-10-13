// swift-tools-version:5.6
import PackageDescription

let version = "1.1.4"
let checksum = "d089835657ca3ba0a1ddd1f4c01717a95a87f2c50cdeb3bd71fcf865741af6f3"

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
    targets: [
        .binaryTarget(
            name: "FjordenSDK",
            url: "https://sdk.fjorden.co/releases/\(version)/FjordenSDK.xcframework.zip",
            checksum: checksum
        )
    ]
)

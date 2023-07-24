// swift-tools-version:5.6
import PackageDescription

let version = "1.3.1"
let checksum = "2fc3aa7d99ef4a18ac0b43aaf7d450aa92b1db85a35df673c58ecea1a3ec2301"

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

// swift-tools-version:5.6
import PackageDescription

let version = "1.2.0"
let checksum = "b3b7556c1b38484a2dca8a78691ca1b98d00b4990f0d234852efc4ae559c02eb"

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

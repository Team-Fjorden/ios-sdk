// swift-tools-version:5.7
import PackageDescription

let version = "1.1.4"
let checksum = "d722646bed700e7d7a2535d2b8595b1ecd76219c00eafde2a6b245dd7fca842a"

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

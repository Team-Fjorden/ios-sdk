// swift-tools-version:5.6
import PackageDescription

let version = "1.1.3"
let checksum = "acb0ee9723b0c59e6f1098a2f8cfb9be9b63fb40682a940bdace0ce6750f853e"

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

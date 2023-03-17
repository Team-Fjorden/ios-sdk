// swift-tools-version:5.6
import PackageDescription

let version = "1.3.0"
let checksum = "20361e1e5d3ccaa643c4d818e51a63f65433ac74516f0d4e4db5dcc02c47e64b"

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

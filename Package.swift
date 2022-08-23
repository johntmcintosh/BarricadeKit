// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BarricadeKit",
    products: [
        .library(
            name: "BarricadeKit",
            targets: ["BarricadeKit"]),
    ],
    targets: [
        .target(
            name: "BarricadeKit",
            dependencies: [],
            path: "./BarricadeKit/Core"),
        .testTarget(
            name: "BarricadeKitTests",
            dependencies: ["BarricadeKit"],
            path: "./BarricadeKit/Test"),
    ]
)

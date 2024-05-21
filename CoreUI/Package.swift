// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUI",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "CoreUI",
            targets: ["CoreUI"]),
    ],
    targets: [
        .target(
            name: "CoreUI"),
        .testTarget(
            name: "CoreUITests",
            dependencies: ["CoreUI"]),
    ]
)

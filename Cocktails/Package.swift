// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cocktails",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Cocktails",
            targets: ["Cocktails"]),
    ],
    targets: [
        .target(
            name: "Cocktails"),
        .testTarget(
            name: "CocktailsTests",
            dependencies: ["Cocktails"]),
    ]
)

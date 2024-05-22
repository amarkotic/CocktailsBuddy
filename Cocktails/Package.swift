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
    dependencies: [
        .package(name: "Networking", path: "../Networking"),
    ],
    targets: [
        .target(
            name: "Cocktails",
            dependencies: [
                "Networking"
            ]),
        .testTarget(
            name: "CocktailsTests",
            dependencies: ["Cocktails"]),
    ]
)

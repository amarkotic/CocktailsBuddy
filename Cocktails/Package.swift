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
        .package(name: "CoreUI", path: "../CoreUI"),
        .package(name: "Networking", path: "../Networking"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.11.0")
    ],
    targets: [
        .target(
            name: "Cocktails",
            dependencies: [
                "CoreUI",
                "Networking",
                .product(name: "Kingfisher", package: "Kingfisher"),
            ]),
        .testTarget(
            name: "CocktailsTests",
            dependencies: ["Cocktails"]),
    ]
)

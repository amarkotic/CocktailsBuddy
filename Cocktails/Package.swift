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
        .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.11.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.3.0")
    ],
    targets: [
        .target(
            name: "Cocktails",
            dependencies: [
                "CoreUI",
                "Networking",
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "Dependencies", package: "swift-dependencies")
            ]),
        .testTarget(
            name: "CocktailsTests",
            dependencies: ["Cocktails"]),
    ]
)

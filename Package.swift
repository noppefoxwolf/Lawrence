// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lawrence",
    platforms: [.macOS(.v11)],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.115.1"),
    ],
    targets: [
        .executableTarget(
            name: "Lawrence",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ]
        ),
    ]
)

// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "jsonpath",
    products: [
        .executable(name: "jsonpath", targets: ["jsonpath"]),
    ],
    dependencies: [
        .package(url: "https://github.com/KittyMac/Chronometer.git", from: "0.1.0"),
        .package(url: "https://github.com/KittyMac/Hitch.git", from: "0.4.0"),
        .package(url: "https://github.com/KittyMac/Spanker.git", from: "0.2.0"),
        .package(url: "https://github.com/KittyMac/Sextant.git", from: "0.4.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "jsonpath",
            dependencies: [
                "Hitch",
                "Spanker",
                "Chronometer",
                "Sextant",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "jsonpathTests",
            dependencies: [
                "jsonpath"
            ]),
    ]
)

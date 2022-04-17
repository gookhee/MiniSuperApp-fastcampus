// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CombineUtil",
            targets: ["CombineUtil"]
        ),
        .library(
            name: "RIBsUtil",
            targets: ["RIBsUtil"]
        ),
        .library(
            name: "SuperUI",
            targets: ["SuperUI"]
        ),
        .library(
            name: "FoundationExt",
            targets: ["FoundationExt"]
        ),
        .library(
            name: "CleanSwiftUtil",
            targets: ["CleanSwiftUtil"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "CombineExt", url: "https://github.com/CombineCommunity/CombineExt", .exact("1.5.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CombineUtil",
            dependencies: [
                "CombineExt"
            ]
        ),
        .target(
            name: "RIBsUtil",
            dependencies: [
            ]
        ),
        .target(
            name: "SuperUI",
            dependencies: [
                "RIBsUtil"
            ]
        ),
        .target(
            name: "FoundationExt",
            dependencies: [
            ]
        ),
        .target(
            name: "CleanSwiftUtil",
            dependencies: [
            ]
        ),
    ]
)

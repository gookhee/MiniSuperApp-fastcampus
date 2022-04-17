// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Transport",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TransportHome",
            targets: ["TransportHome"]),
        .library(
            name: "TransportHomeImp",
            targets: ["TransportHomeImp"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Platform", path: "../Platform"),
        .package(name: "Finance", path: "../Finance")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TransportHome",
            dependencies: [
            ]
        ),
        .target(
            name: "TransportHomeImp",
            dependencies: [
                "TransportHome",
                .product(name: "FinanceRepository", package: "Finance"),
                .product(name: "Topup", package: "Finance"),
                .product(name: "CombineUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform"),
                .product(name: "FoundationExt", package: "Platform")
            ],
            resources: [
                .process("Resource")
            ]
        ),
    ]
)

// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Finance",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AddPaymentMethod",
            targets: ["AddPaymentMethod"]
        ),
        .library(
            name: "AddPaymentMethodImp",
            targets: ["AddPaymentMethodImp"]
        ),
        .library(
            name: "FinanceEntity",
            targets: ["FinanceEntity"]
        ),
        .library(
            name: "FinanceRepository",
            targets: ["FinanceRepository"]
        ),
        .library(
            name: "Topup",
            targets: ["Topup"]
        ),
        .library(
            name: "TopupImp",
            targets: ["TopupImp"]
        ),
        .library(
            name: "FinanceHome",
            targets: ["FinanceHome"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Platform", path: "../Platform")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AddPaymentMethod",
            dependencies: [
                "FinanceEntity",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "CleanSwiftUtil", package: "Platform"),
            ]
        ),
        .target(
            name: "AddPaymentMethodImp",
            dependencies: [
                "AddPaymentMethod",
                "FinanceEntity",
                "FinanceRepository",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform"),
                .product(name: "CleanSwiftUtil", package: "Platform"),
            ]
        ),
        .target(
            name: "FinanceEntity",
            dependencies: []
        ),
        .target(
            name: "FinanceRepository",
            dependencies: [
                "FinanceEntity",
                .product(name: "CombineUtil", package: "Platform")
            ]
        ),
        .target(
            name: "Topup",
            dependencies: [
                .product(name: "CleanSwiftUtil", package: "Platform"),
            ]
        ),
        .target(
            name: "TopupImp",
            dependencies: [
                "Topup",
                "FinanceEntity",
                "FinanceRepository",
                "AddPaymentMethod",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform"),
                .product(name: "FoundationExt", package: "Platform"),
                .product(name: "CleanSwiftUtil", package: "Platform"),
            ]
        ),
        .target(
            name: "FinanceHome",
            dependencies: [
                "FinanceEntity",
                "FinanceRepository",
                "AddPaymentMethod",
                "Topup",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform"),
                .product(name: "FoundationExt", package: "Platform"),
                .product(name: "CleanSwiftUtil", package: "Platform"),
            ]
        ),
    ]
)

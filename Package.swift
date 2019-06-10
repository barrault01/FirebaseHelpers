// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseHelpers",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "FirebaseHelpers",
            targets: ["FirebaseHelpers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/googleapis/google-auth-library-swift.git", .revision("f7371c8b4f3ce41a1b63b87c6fb04c53db850484"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FirebaseHelpers",
            dependencies: ["OAuth2"]),
        .testTarget(
            name: "FirebaseHelpersTests",
            dependencies: ["FirebaseHelpers"]),
    ]
)

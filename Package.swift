// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "XCEArrayExt",
    products: [
        .library(
            name: "XCEArrayExt",
            targets: [
                "XCEArrayExt"
            ]
        )
    ],
    targets: [
        .target(
            name: "XCEArrayExt",
            path: "Sources/Core"
        ),
        .testTarget(
            name: "XCEArrayExtAllTests",
            dependencies: [
                "XCEArrayExt"
            ],
            path: "Tests/AllTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
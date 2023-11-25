// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "SwiftCareBackend",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.83.1"),
        .package(url: "https://github.com/apple/swift-algorithms.git", exact: "1.2.0"),
        .package(url: "https://github.com/apple/swift-collections.git", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                "SwiftCare"
            ]
        ),
        .target(
            name: "SwiftCare",
            dependencies: [
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Algorithms", package: "swift-algorithms")
            ]
        )
    ]
)

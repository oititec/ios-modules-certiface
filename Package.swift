// swift-tools-version:5.9

import PackageDescription

let version = "2.1.1"

let package = Package(
    name: "CertifaceSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "CertifaceSDK",
            targets: ["CertifaceSDKWrapper"]
        ),
        .library(
            name: "CertifaceDocSDK",
            targets: ["CertifaceDocSDKWrapper"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/iproov/ios.git",
            exact: "12.5.0"
        ),
        .package(
            url: "https://github.com/oititec/ios-liveness3d-ft.git",
            exact: "9.7.130"
        )
    ],
    targets: [

        // MARK: - Wrappers

        .target(
            name: "CertifaceSDKWrapper",
            dependencies: [
                .target(name: "CertifaceSDK"),
                .target(name: "CertifaceIProov"),
                .target(name: "CertifaceFacetec"),

                .product(name: "iProov", package: "ios"),
                .product(name: "FaceTecSDK", package: "ios-liveness3d-ft"),

                .target(name: "CertifaceComponents"),
                .target(name: "CertifaceUtils"),
                .target(name: "CertifaceNetwork"),
                .target(name: "CertifaceSecurity")
            ],
            path: "Sources/CertifaceSDKWrapper"
        ),

        .target(
            name: "CertifaceDocSDKWrapper",
            dependencies: [
                .target(name: "CertifaceDocSDK"),

                .target(name: "CertifaceComponents"),
                .target(name: "CertifaceUtils"),
                .target(name: "CertifaceNetwork"),
                .target(name: "CertifaceSecurity")
            ],
            path: "Sources/CertifaceDocSDKWrapper"
        ),

        // MARK: - Binary SDKs

        .binaryTarget(
            name: "CertifaceSDK",
            path: "Frameworks/CertifaceSDK.xcframework"
        ),

        .binaryTarget(
            name: "CertifaceDocSDK",
            path: "Frameworks/CertifaceDocSDK.xcframework"
        ),

        .binaryTarget(
            name: "CertifaceIProov",
            path: "Frameworks/CertifaceIProov.xcframework"
        ),

        .binaryTarget(
            name: "CertifaceFacetec",
            path: "Frameworks/CertifaceFacetec.xcframework"
        ),

        // MARK: - Shared Modules

        .binaryTarget(
            name: "CertifaceComponents",
            path: "Frameworks/CertifaceComponents.xcframework"
        ),

        .binaryTarget(
            name: "CertifaceUtils",
            path: "Frameworks/CertifaceUtils.xcframework"
        ),

        .binaryTarget(
            name: "CertifaceNetwork",
            path: "Frameworks/CertifaceNetwork.xcframework"
        ),

        .binaryTarget(
            name: "CertifaceSecurity",
            path: "Frameworks/CertifaceSecurity.xcframework"
        )
    ]
)
// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CS_iOS_SDK",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "ContentsquareModule",
            targets: ["ContentsquareModuleWrapper"]),
    ],
    dependencies: [
        .package(
            name: "SwiftProtobuf",
            url: "https://github.com/apple/swift-protobuf.git",
            "1.15.0" ... "1.26.0"),
        .package(
            name: "CSCrashReporter",
            url: "https://github.com/ContentSquare/CS_iOS_CrashReporter.git",
            .exact("1.0.0")),
    ],
    targets: [
        // binaryTarget doesn't support dependency, use a wrapper to fix this.
        .target(
            name: "ContentsquareModuleWrapper",
            dependencies: [
                .target(name: "ContentsquareModule"),
                "SwiftProtobuf",
                "CSCrashReporter"
            ],
            path: "ContentsquareModuleWrapper",
            resources: [
                .process("ContentsquareBundle.bundle"),
                .copy("PrivacyInfo.xcprivacy")
            ]
        ),
        .binaryTarget(
            name: "ContentsquareModule",
            url: "https://github.com/ContentSquare/CS_iOS_SDK/releases/download/4.38.1/ContentsquareModuleSwiftPackage.xcframework.zip",
            checksum: "99318ab9eef342401aefe7205f6a88c8be160ccfb45df3f5af08702fac0aa342"),
    ]
)
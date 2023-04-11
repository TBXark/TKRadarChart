// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TKRadarChart",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "TKRadarChart",
            targets: ["TKRadarChart"]),
    ],
    targets: [
        .target(
            name: "TKRadarChart"),
    ]
)

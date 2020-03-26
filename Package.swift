// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Emoji",
    products: [
        .library(name: "Emoji", targets: ["Emoji"])
    ],
    targets: [
        .target(
            name: "Emoji"
        )
    ]
)

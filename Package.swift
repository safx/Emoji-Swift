// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Emoji",
    products: [
      .library(
        name: "Emoji",
        targets: ["Emoji"]
      )
    ],
    targets: [
      .target(
        name: "Emoji"
      ),
      .testTarget(
        name: "EmojiTests",
        dependencies: [
          .target(name: "Emoji")
        ]
      )
    ]
)

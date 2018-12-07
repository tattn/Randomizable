// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Randomizable",
    products: [
        .library(name: "Randomizable", targets: ["Randomizable"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Randomizable", 
            path: "Sources/",
            exclude: []
            )
    // .testTarget(
    //     name: "RandomizableTests",
    //     dependencies: ["Randomizable"]
    //     ),
    ],
    swiftLanguageVersions: [4]
)

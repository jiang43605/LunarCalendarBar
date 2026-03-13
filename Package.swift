// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LunarCalendarBar",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "LunarCalendarBar",
            targets: ["LunarCalendarBar"]
        )
    ],
    targets: [
        .executableTarget(
            name: "LunarCalendarBar",
            path: "LunarCalendarBar",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
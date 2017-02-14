import PackageDescription

let package = Package(
    name: "Funtime",
    targets: [
        // TODO: Make TestFixtures a test-only dependency when SwiftPM supports it.
        // The TestFixtures module is only used by the tests. It should be a test-only dependency, but the Swift Package Manager doesn't support that (as of Swift 3.0.2).
        Target(name: "Funtime", dependencies: ["TestFixtures"])
    ]
)

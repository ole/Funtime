# Funtime

A Swift interface for the Objective-C Runtime API.

Status: very incomplete and half-baked.

## Usage

The project is currently an Xcode framework target for macOS. Open the project in Xcode and run the tests to verify everything works.

I would love to turn this into a Swift Package Manager<sup>*</sup> package, but SwiftPM currently (as of Swift 3.0.2) lacks at least two crucial features:

* No test-only dependencies. Since SwiftPM doesn't support mixed-language modules, we'd need a separate TestFixtures module that contains the Objective-C classes we use as input data for the unit tests.
* There's no way to pass build flags to the compiler. We need this to enable ARC for the Objective-C TestFixtures module. This is a deal breaker.

(*) In fact, this project started out as a SwiftPM package, but I had to convert it to an Xcode project for the reasons mentioned above.

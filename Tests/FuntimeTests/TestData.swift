import Foundation

// Test types

class EmptySwiftClass {}

struct SwiftStruct { var name: String }

class NSObjectSubclass: NSObject {
    var firstName: String
    var lastName: String

    init(first: String, last: String) {
        self.firstName = first
        self.lastName = last
    }
}

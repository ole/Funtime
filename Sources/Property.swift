import ObjectiveC

/// A wrapper around a property (`objc_property_t`)
/// in the Objective-C runtime.
public final class Property {
    public let base: objc_property_t

    public init(base: objc_property_t) {
        self.base = base
    }

    public var name: String {
        return String(cString: property_getName(base))
    }
}

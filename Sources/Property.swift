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

    public var attributeString: String {
        return String(cString: property_getAttributes(base))
    }

    public var typeEncoding: String {
        guard let typeEncoding = attributes()["T"] else {
            fatalError("typeEncoding of property \(name) is unexpectedly nil")
        }
        return typeEncoding
    }

    /// - Complexity: O(_n_) where _n_ is the number of attributes.
    /// - TODO: Memoize/cache the result to make properties that access
    ///   the attributes O(1). This shouldn't be a problem because a
    ///   property's attributes are immutable.
    public func attributes() -> [String: String] {
        var attributesCount: UInt32 = 0
        let attributeList = property_copyAttributeList(base, &attributesCount)
        guard let list = attributeList else { return [:] }
        let listLength = Int(attributesCount)
        defer {
            list.deinitialize(count: listLength)
            list.deallocate(capacity: listLength)
        }
        let buffer = UnsafeBufferPointer(start: list, count: listLength)
        var result: [String: String] = [:]
        for attribute in buffer {
            let name = String(cString: attribute.name)
            let value = String(cString: attribute.value)
            result[name] = value
        }
        return result
    }
}

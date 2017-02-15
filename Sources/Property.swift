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

    public var isAtomic: Bool { return !isNonAtomic }
    public var isNonAtomic: Bool { return attributes["N"] != nil }
    public var isAssign: Bool { return !isRetain && !isCopy }
    public var isReadOnly: Bool { return attributes["R"] != nil }
    public var isRetain: Bool { return attributes["&"] != nil }
    public var isCopy: Bool { return attributes["C"] != nil }
    public var isWeak: Bool { return attributes["W"] != nil }
    public var isDynamic: Bool { return attributes["D"] != nil }
    public var isGarbageCollected: Bool { return attributes["P"] != nil }
    public var customGetter: String? { return attributes["G"] }
    public var customSetter: String? { return attributes["S"] }
    public var backingIVar: String? { return attributes["V"] }

    /// The property's type encoding string as returned by the `@encode()` compiler directive, e.g. `"i"` for an `int`, `"@"` for `id`, or `"@\"NSString\"` for `NSString *`.
    ///
    /// The format is documented in the ["Type Encodings"](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1) section of the [Objective-C Runtime Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html).
    public var typeEncoding: String {
        guard let typeEncoding = attributes["T"] else {
            fatalError("typeEncoding of property \(name) is unexpectedly nil")
        }
        return typeEncoding
    }

    public var attributeString: String {
        return String(cString: property_getAttributes(base))
    }

    /// A dictionary of the property's attributes.
    ///
    /// The keys of the dictionary correspond to the letters described in the ["Property Type String"](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6) section of the [Objective-C Runtime Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html).
    ///
    /// The values for most keys are empty strings — the presence of the key signifies the presence of the corresponding attribute, without the need for another value. Exceptions to this rule are the T (type encoding), G (custom getter name), and S (custom setter name) attributes.
    ///
    ///     Key  Meaning
    ///     -------------
    ///     V    Value is name of the backing ivar.
    ///     R    readonly
    ///     C    copy
    ///     &    retain
    ///     N    nonatomic
    ///     G    Value is the custom getter name.
    ///     S    Value is the custom setter name.
    ///     D    @dynamic
    ///     W    weak
    ///     P    garbage-collected
    ///     T    Value is the type encoding (@encode string).
    ///     t    Value is the type using old-style encoding.
    public private(set) lazy var attributes: [String:String] = self._attributes()

    /// Helper function to lazily initialize `attributes`.
    /// - Complexity: O(_n_) where _n_ is the number of attributes.
    private func _attributes() -> [String:String] {
        var attributesCount: UInt32 = 0
        let attributeList = property_copyAttributeList(base, &attributesCount)
        guard let list = attributeList else { return [:] }
        let listLength = Int(attributesCount)
        defer {
            list.deinitialize(count: listLength)
            list.deallocate(capacity: listLength)
        }
        let buffer = UnsafeBufferPointer(start: list, count: listLength)
        var result: [String:String] = [:]
        for attribute in buffer {
            let name = String(cString: attribute.name)
            let value = String(cString: attribute.value)
            result[name] = value
        }
        return result
    }
}

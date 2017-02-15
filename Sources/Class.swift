import ObjectiveC

/**
 A wrapper around a class object (`AnyClass` in Swift; `Class` in Objective-C) in the Objective-C runtime.
 */
public final class Class {
    public let base: AnyClass

    /// Initializes a Class instance with a class object.
    ///
    /// `base` should be a class object that's known to the Objective-C
    /// runtime (i.e. a subclass of `NSObject` in most cases).
    /// However, the initializer will still succeed if `base` is a
    /// type that is not known to the Objective-C runtime. Swift
    /// automatically wraps such types in an opaque `NSObject`.
    public init(base: AnyClass) {
        self.base = base
    }

    /// Initializes a Class instance from an object. The resulting
    /// `Class` instance represents the class object of `instance`.
    ///
    /// `instance` should have a class type that's known to the
    /// Objective-C runtime (i.e. a subclass of `NSObject` in most 
    /// cases). However, the initializer will still succeed if 
    /// `instance` is a type that is not known to the Objective-C 
    /// runtime. Swift automatically wraps such types in an opaque
    /// `NSObject`.
    public init(of instance: Any) {
        self.base = object_getClass(instance)
    }

    public var name: String {
        return String(cString: class_getName(base))
    }

    /// The class object for the superclass of this class object,
    /// or `nil` if this class object is a root class.
    public var superclass: Class? {
        guard let superclass = class_getSuperclass(base) else {
            return nil
        }
        return Class(base: superclass)
    }

    /// Returns `true` if the represented class object is a metaclass.
    public var isMetaclass: Bool {
        return class_isMetaClass(base)
    }

    /// Returns the metaclass object of the represented class object.
    public var metaclass: Class {
        // The metaclass is the class of a class object.
        return Class(of: base)
    }

    /**
     A dictionary of the class's properties. The keys are the names of the properties and the values are `Property` instances. Properties declared by a superclass are not included.
     
     This returns the class's _instance_ properties. To retrieve a class's _class_ properties, use `metaclass.properties`.
     
     - Note: Class properties have been introduced with macOS 10.12 and iOS 10.0. The Objective-C runtime handles them correctly since macOS 10.11/iOS 9.0. If the deployment target is lower than macOS 10.11 or iOS 9.0, the Objective-C runtime will not find any class properties. The relevant version is the deployment target the inspected class has been compiled with, not the deployment target of the calling code. See https://lists.swift.org/pipermail/swift-users/Week-of-Mon-20170213/004755.html for details.
     
     - Complexity: O(_n_) where _n_ is the number of properties the
       class has.
     */
    public func properties() -> [String:Property] {
        var propertiesCount: UInt32 = 0
        let propertyList = class_copyPropertyList(base, &propertiesCount)
        guard let list = propertyList else { return [:] }
        let listLength = Int(propertiesCount) + 1 // Including NULL terminator
        defer {
            list.deinitialize(count: listLength)
            list.deallocate(capacity: listLength)
        }
        let buffer = UnsafeBufferPointer(start: list, count: listLength)
        let properties = buffer.flatMap { property in property.map(Property.init(base:)) }
        var result: [String:Property] = [:]
        for property in properties {
            result[property.name] = property
        }
        return result
    }
}

extension Class: Equatable {
    public static func ==(lhs: Class, rhs: Class) -> Bool {
        return lhs.base === rhs.base
    }
}

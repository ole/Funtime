import Funtime
import TestFixtures
import XCTest

class ClassTests: XCTestCase {
    func testName() {
        let sut = Class(base: BaseClass.self)
        XCTAssertEqual(sut.name, "BaseClass")
    }

    func testNameWithFoundationClass() {
        let sut = Class(base: NSDate.self)
        XCTAssertEqual(sut.name, "NSDate")
    }

    func testNameWorksWithClassNotDerivedFromNSObject() {
        let sut = Class(base: NSProxy.self)
        XCTAssertEqual(sut.name, "NSProxy")
    }

    func testDoesNotCrashIfInitializedWithPureSwiftClass() {
        let sut = Class(base: EmptySwiftClass.self)
        // The exact contents of sut.name are not important. They may change in future Swift versions or if we rename this function or module.
        XCTAssert(sut.name.hasSuffix("EmptySwiftClass"))
    }

    func testDoesNotCrashIfInitializedWithPureSwiftValue() {
        let person = SwiftStruct(name: "Jane")
        let sut = Class(of: person)
        // The exact contents of sut.name are not important. They may change in future Swift versions.
        XCTAssertEqual(sut.name, "_SwiftValue")
    }

    func testSuperclass() {
        let sut = Class(base: SubClass.self)
        let expected = Class(base: BaseClass.self)
        XCTAssertEqual(sut.superclass, expected)
    }

    func testSuperclassOfNSObjectIsNil() {
        let sut = Class(base: NSObject.self)
        XCTAssertNil(sut.superclass)
    }

    func testSuperclassOfNSMutableStringIsNSString() {
        let sut = Class(base: NSMutableString.self)
        XCTAssert(sut.superclass!.base === NSString.self)
    }

    func testClassesWithSameBaseAreEqual() {
        let lhs = Class(base: NSArray.self)
        let rhs = Class(base: NSArray.self)
        XCTAssertEqual(lhs, rhs)
    }

    func testMetaclass() {
        let sut = Class(base: NSMutableString.self)
        XCTAssertFalse(sut.isMetaclass)
        XCTAssertTrue(sut.metaclass.isMetaclass)
        XCTAssertTrue(sut.metaclass.base === object_getClass(NSMutableString.self))
    }

    func testMetaclassOfMetaclassIsMetaclassOfNSObject() {
        let sut = Class(base: NSMutableString.self)
        let nsobj = Class(base: NSObject.self)
        XCTAssertEqual(sut.metaclass.metaclass, nsobj.metaclass)
    }

    func testPropertiesCountIsCorrect() {
        let sut = Class(base: TwoProperties.self)
        let properties = sut.properties()
        XCTAssertEqual(properties.count, 2)
        XCTAssertEqual(properties.keys.sorted(), ["one", "two"])
    }

    func testPropertiesKeysArePropertyNames() {
        let sut = Class(base: TwoProperties.self)
        let properties = sut.properties()
        XCTAssertEqual(properties.keys.sorted(), ["one", "two"])
    }

    func testPropertiesDoesntIncludeSuperclassProperties() {
        let sut = Class(base: ThreeMoreProperties.self)
        let properties = sut.properties()
        XCTAssertEqual(properties.count, 3)
        XCTAssertEqual(properties.keys.sorted(), ["five", "four", "three"])
    }

    func testClassPropertiesAreNotListedOnInstance() {
        let sut = Class(base: AssortedProperties.self)
        let properties = sut.properties()
        XCTAssertNil(properties["classDoubleProperty"])
    }

    func testClassPropertiesAreListedOnMetaclass() {
        // The Objective-C runtime doesn't handle class properties on deplyment targets < macOS 10.11/iOS 9.0. See https://lists.swift.org/pipermail/swift-users/Week-of-Mon-20170213/004755.html for details.
        guard isDeploymentTargetAtLeast(macOS: __MAC_10_11, iOS: __IPHONE_9_0, tvOS: __TVOS_9_0, watchOS: __WATCHOS_2_0) else {
            print("Omitting testClassPropertiesAreListedOnMetaclass(), requires deployment target >= macOS 10.11, iOS 9.0, tvOS 9.0, watchOS 2.0.")
            return
        }
        let sut = Class(of: AssortedProperties.self)
        let properties = sut.properties()
        XCTAssertNotNil(properties["classProperty"])
        XCTAssertEqual(properties["classProperty"]?.typeEncoding, "d")
    }
}

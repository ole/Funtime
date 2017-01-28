import Foundation
import Funtime
import XCTest

class ClassTests: XCTestCase {
    func testName() {
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
        XCTAssertTrue(sut.metaclass.base === object_getClass(NSMutableString.self))
        XCTAssertTrue(sut.metaclass.isMetaclass)
        // The metaclass's metaclass is NSObject's metaclass
        let nsobj = Class(base: NSObject.self)
        XCTAssertEqual(sut.metaclass.metaclass, nsobj.metaclass)
    }

    func testProperties() {
        let sut = Class(base: NSObjectSubclass.self)
        let properties = sut.properties
        XCTAssertEqual(properties.count, 2)
    }
}

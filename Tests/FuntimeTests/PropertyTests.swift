import Funtime
import XCTest

class PropertyTests: XCTestCase {
    func testName() {
        let cls = Class(base: TwoProperties.self)
        let properties = cls.properties()
        XCTAssertEqual(properties.count, 2)
        XCTAssertEqual(properties["one"]?.name, "one")
        XCTAssertEqual(properties["two"]?.name, "two")
    }

    func testIsAtomicAndIsNonAtomic() {
        let cls = Class(base: AssortedProperties.self)
        let atomic = cls.properties()["atomicProperty"]
        let nonAtomic = cls.properties()["nonAtomicProperty"]
        XCTAssert(atomic?.isAtomic == true)
        XCTAssert(atomic?.isNonAtomic == false)
        XCTAssert(nonAtomic?.isAtomic == false)
        XCTAssert(nonAtomic?.isNonAtomic == true)
    }

    func testIsReadOnly() {
        let cls = Class(base: AssortedProperties.self)
        let readonly = cls.properties()["readOnlyProperty"]
        let readwrite = cls.properties()["nsStringProperty"]
        XCTAssert(readonly?.isReadOnly == true)
        XCTAssert(readwrite?.isReadOnly == false)
    }

    func testIsAssignRetainCopy() {
        let cls = Class(base: AssortedProperties.self)
        let assign = cls.properties()["assignProperty"]
        let retain = cls.properties()["retainProperty"]
        let copy = cls.properties()["someCopyProperty"]
        XCTAssert(assign?.isAssign == true)
        XCTAssert(assign?.isRetain == false)
        XCTAssert(assign?.isCopy == false)
        XCTAssert(retain?.isAssign == false)
        XCTAssert(retain?.isRetain == true)
        XCTAssert(retain?.isCopy == false)
        XCTAssert(copy?.isAssign == false)
        XCTAssert(copy?.isRetain == false)
        XCTAssert(copy?.isCopy == true)
    }

    func testIsWeak() {
        let cls = Class(base: AssortedProperties.self)
        let weak = cls.properties()["weakProperty"]
        let strong = cls.properties()["idProperty"]
        XCTAssert(weak?.isWeak == true)
        XCTAssert(strong?.isWeak == false)
    }

    func testTypeEncoding() {
        let cls = Class(base: AssortedProperties.self)
        let properties = cls.properties()
        let intProperty = properties["intProperty"]
        let idProperty = properties["idProperty"]
        let nsStringProperty = properties["nsStringProperty"]
        XCTAssertEqual(intProperty?.typeEncoding, "i")
        XCTAssertEqual(idProperty?.typeEncoding, "@")
        XCTAssertEqual(nsStringProperty?.typeEncoding, "@\"NSString\"")
    }

    func testAttributes() {
        let cls = Class(base: AssortedProperties.self)
        let sut = cls.properties()["nonAtomicCopyReadonlyArrayProperty"]
        let attributes = sut?.attributes
        XCTAssertEqual(attributes?.count, 5)
        XCTAssertEqual(attributes?["T"], "@\"NSArray\"")
        XCTAssertEqual(attributes?["V"], "_nonAtomicCopyReadonlyArrayProperty")
        XCTAssertEqual(attributes?["R"], "")
        XCTAssertEqual(attributes?["C"], "")
        XCTAssertEqual(attributes?["N"], "")
        XCTAssertNil(attributes?["&"])
        XCTAssertNil(attributes?["G"])
        XCTAssertNil(attributes?["S"])
        XCTAssertNil(attributes?["D"])
        XCTAssertNil(attributes?["W"])
        XCTAssertNil(attributes?["P"])
        XCTAssertNil(attributes?["t"])
    }

    func testAttributeString() {
        let cls = Class(base: AssortedProperties.self)
        let sut = cls.properties()["nonAtomicCopyReadonlyArrayProperty"]
        XCTAssertEqual(sut?.attributeString, "T@\"NSArray\",R,C,N,V_nonAtomicCopyReadonlyArrayProperty")
    }
}

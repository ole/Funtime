import Funtime
import TestFixtures
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

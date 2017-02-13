import Funtime
import XCTest

class PropertyTests: XCTestCase {
    func testName() {
        let cls = Class(base: NSObjectSubclass.self)
        let sut = cls.properties()
        XCTAssertEqual(sut.count, 2)
        XCTAssertEqual(sut[0].name, "firstName")
        XCTAssertEqual(sut[1].name, "lastName")
    }

    func testIsAtomic() {
        let cls = Class(base: NSObjectSubclass.self)
        let sut = cls.properties()[0]
        XCTAssertFalse(sut.isAtomic)
    }

    func testIsNonAtomic() {
        let cls = Class(base: NSObjectSubclass.self)
        let sut = cls.properties()[0]
        XCTAssertTrue(sut.isNonAtomic)
    }

    func testAttributeString() {
        let cls = Class(base: NSObjectSubclass.self)
        let sut = cls.properties()[0]
        XCTAssertEqual(sut.attributeString, "T@\"NSString\",N,C,VfirstName")
    }

    func testTypeEncoding() {
        let cls = Class(base: NSObjectSubclass.self)
        let sut = cls.properties()[0]
        XCTAssertEqual(sut.typeEncoding, "@\"NSString\"")
    }

    func testAttributes() {
        let cls = Class(base: NSObjectSubclass.self)
        let sut = cls.properties()[0]
        let attributes = sut.attributes
        print(attributes)
    }
}

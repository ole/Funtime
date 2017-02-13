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
    }
}

import Funtime
import XCTest

class PropertyTests: XCTestCase {
    func testName() {
        let cls = Class(base: NSObjectSubclass.self)
        let expected = ["firstName", "lastName"]
        XCTAssertEqual(cls.properties.map { $0.name }, expected)
    }
}

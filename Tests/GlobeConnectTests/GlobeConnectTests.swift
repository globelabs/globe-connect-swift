import XCTest
@testable import GlobeConnect

class GlobeConnectTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(GlobeConnect().text, "Hello, World!")
    }


    static var allTests : [(String, (GlobeConnectTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}

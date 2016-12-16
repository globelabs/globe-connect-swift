import XCTest
@testable import GlobeConnect

class LocationQueryTests: XCTestCase {
    func testGetLocation() {
        let expectation = self.expectation(description: "testGetLocation")

        let locationQuery = LocationQuery(accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA")

        locationQuery
            .getLocation(
                address: "09271223448",
                success: { json in
                    dump(json)
                    expectation.fulfill()
                },
                failure: { error in
                    expectation.fulfill()
                })

        waitForExpectations(timeout: 40, handler: nil)
    }

    static var allTests : [(String, (LocationQueryTests) -> () throws -> Void)] {
        return [
            // ("testGetLocation", testGetLocation)
        ]
    }
}

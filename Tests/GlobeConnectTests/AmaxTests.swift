import XCTest
@testable import GlobeConnect

class AmaxTests: XCTestCase {
    func testSendRewardRequest() {
        let expectation = self.expectation(description: "testSendRewardRequest")

        // initialize
        let amax = Amax(
            appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
            appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e"
        )

        // perform request
        amax.sendRewardRequest(
            address: "9271223448",
            promo: "FREE10MB",
            rewardsToken: "w7hYKxrE7ooHqXNBQkP9lg",
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 40, handler: nil)
    }

    static var allTests : [(String, (AmaxTests) -> () throws -> Void)] {
        return [
            // ("testSendRewardRequest", testSendRewardRequest)
        ]
    }
}

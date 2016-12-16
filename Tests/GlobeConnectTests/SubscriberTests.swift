import XCTest
@testable import GlobeConnect

class SubscriberTests: XCTestCase {
    func testGetSubscriberBalance() {
        let expectation = self.expectation(description: "testGetSubscriberBalance")

        // initialize
        let subscriber = Subscriber(accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA")

        // send request
        subscriber.getSubscriberBalance(
            address: "639271223448",
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testGetSubscriberReloadAmount() {
        let expectation = self.expectation(description: "testGetSubscriberReloadAmount")

        // initialize
        let subscriber = Subscriber(accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA")

        // send request
        subscriber
            .getSubscriberReloadAmount(
                address: "639271223448",
                success: { json in
                    dump(json)
                    expectation.fulfill()
                },
                failure: { error in
                    expectation.fulfill()
                })

        waitForExpectations(timeout: 30, handler: nil)
    }

    static var allTests : [(String, (SubscriberTests) -> () throws -> Void)] {
        return [
            // ("testGetSubscriberBalance", testGetSubscriberBalance),
            // ("testGetSubscriberReloadAmount", testGetSubscriberReloadAmount)
        ]
    }
}

import Foundation
import XCTest
@testable import GlobeConnect

class UssdTests: XCTestCase {
    func testSendUssdRequest() {
        let expectation = self.expectation(description: "testSendUssdRequest")

        // initialize
        let ussd = Ussd(
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA",
            shortCode: "21584130"
        )

        // send request
        ussd.sendUssdRequest(
            address: "639271223448",
            message: "Simple USSD Message\nOption - 1\nOption - 2",
            flash: false,
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testReplyUssdRequest() {
        let expectation = self.expectation(description: "testReplyUssdRequest")

        // initialize
        let ussd = Ussd(
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA",
            shortCode: "21584130"
        )

        // send request
        ussd.replyUssdRequest(
            address: "639271223448",
            message: "Simple USSD Message\nOption - 1\nOption - 2",
            sessionId: "012345678912",
            flash: false,
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 30, handler: nil)
    }

    static var allTests : [(String, (UssdTests) -> () throws -> Void)] {
        return [
            // ("testSendUssdRequest", testSendUssdRequest),
            // ("testReplyUssdRequest", testReplyUssdRequest)
        ]
    }
}

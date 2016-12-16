import XCTest
@testable import GlobeConnect

class SmsTests: XCTestCase {
    func testSendBinaryMessage() {
        let expectation = self.expectation(description: "testSendBinaryMessage")

        // initialize
        let sms = Sms(
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA",
            shortCode: "21584130"
        )

        sms.sendBinaryMessage(
            address: "09271223448",
            message: "Lorem ipsum",
            header: "06050423F423F4",
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testSendMessage() {
        let expectation = self.expectation(description: "testSendMessage")

        // initialize
        let sms = Sms(
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA",
            shortCode: "21584130"
        )

        sms.sendMessage(
            address: "+639271223448",
            message: "Lorem ipsum",
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 30, handler: nil)
    }

    static var allTests : [(String, (SmsTests) -> () throws -> Void)] {
        return [
            // ("testSendBinaryMessage", testSendBinaryMessage),
            // ("testSendMessage", testSendMessage),
        ]
    }
}

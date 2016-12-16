import XCTest
@testable import GlobeConnect

class PaymentTests: XCTestCase {
    func testSendPaymentRequest() {
        let expectation = self.expectation(description: "testSendPaymentRequest")

        // initialize
        let payment = Payment(
            appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
            appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e",
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA"
        )

        // send request
        payment.sendPaymentRequest(
            amount: 0.00,
            description: "My Application",
            endUserId: "9271223448",
            referenceCode: "41301000111",
            transactionOperationStatus: "Charged",
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 40, handler: nil)
    }

    func testGetLastReferenceCode() {
        let expectation = self.expectation(description: "testGetLastReferenceCode")

        // initialize
        let payment = Payment(
            appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
            appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e",
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA"
        )

        // send request
        payment.getLastReferenceCode(
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 40, handler: nil)
    }

    static var allTests : [(String, (PaymentTests) -> () throws -> Void)] {
        return [
            // ("testSendPaymentRequest", testSendPaymentRequest),
            // ("testGetLastReferenceCode", testGetLastReferenceCode)
        ]
    }
}

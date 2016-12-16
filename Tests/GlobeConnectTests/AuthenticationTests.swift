import XCTest
@testable import GlobeConnect

class AuthenticationTests: XCTestCase {
    func testGetAccessToken() {
        let expectation = self.expectation(description: "testGetAccessToken")

        Authentication().getAccessToken(
            appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
            appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e",
            code: "M8s6gAarub9pebhgEAqKsxdByxHoM5kzf4Mp5js98Bzot8bqjrfaRdG4H4jknpFzr8gKtdx4jnUqbA8KsxqA48frR698IKLRb5S5LBxauo9EkxCMrzk6uorxGEu67Tay49aTxxzu8ozznukMEaXCBRB8GuKjR5MSpB65zIbkA8Bf5eA94se848KUb589RteGkdEFBEddEH6xqRyfjMBqatE4ppBsAe56Bfq4BkjHrXA9Rsqzp5RhMAA6Mu65MAds",
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            })

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testGetAccessUrl() {
        let url = Authentication().getDialogUrl(appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz")
        print(url)
    }

    static var allTests : [(String, (AuthenticationTests) -> () throws -> Void)] {
        return [
            // ("testGetAccessToken", testGetAccessToken),
            // ("testGetAccessUrl", testGetAccessUrl)
        ]
    }
}

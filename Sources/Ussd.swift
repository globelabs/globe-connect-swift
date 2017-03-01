import Foundation

public struct Ussd {
    let accessToken: String
    let shortCode: String

    public typealias SuccessHandler = (JSON) -> Void
    public typealias ErrorHandler = (_ error: Error) -> Void

    public init(accessToken: String, shortCode: String) {
        self.accessToken = accessToken
        self.shortCode = shortCode
    }

    public func sendUssdRequest(
        address: String,
        message: String,
        flash: Bool,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the request url
        let url = "https://devapi.globelabs.com.ph/ussd/v1/outbound/\(self.shortCode)/send/requests?access_token=\(self.accessToken)"

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundUSSDMessageRequest" : [
                "outboundUSSDMessage" : [
                    "message": message
                ],
                "address"       : address,
                "senderAddress" : self.shortCode,
                "flash"         : flash
            ]
        ]

        // set the header
        let headers = [
            "Content-Type" : "application/json; charset=utf-8"
        ]

        // let's convert the payload to JSON
        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )

            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                Request().post(
                    url: url,
                    payload: jsonPayload,
                    headers: headers,
                    callback: { data, _, _ in
                        DispatchQueue.global(qos: .utility).async {
                            do {
                                let jsonResult = try JSON.parse(jsonData: data!)
                                DispatchQueue.main.async {
                                    success?(jsonResult)
                                }
                            } catch {
                                DispatchQueue.main.async {
                                    failure?(error)
                                }
                            }
                        }
                    }
                )
            }
        } catch let error as NSError {
            // oops, error in converting it to JSON
            failure?(error)
        }
    }

    public func replyUssdRequest(
        address: String,
        message: String,
        sessionId: String,
        flash: Bool,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) {
        // set the request url
        let url = "https://devapi.globelabs.com.ph/ussd/v1/outbound/\(self.shortCode)/reply/requests?access_token=\(self.accessToken)"

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundUSSDMessageRequest" : [
                "outboundUSSDMessage" : [
                    "message": message
                ],
                "address"       : address,
                "senderAddress" : self.shortCode,
                "sessionID"     : sessionId,
                "flash"         : flash
            ]
        ]

        // set the header
        let headers = [
            "Content-Type" : "application/json; charset=utf-8"
        ]

        // let's convert the payload to JSON
        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )

            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                Request().post(
                    url: url,
                    payload: jsonPayload,
                    headers: headers,
                    callback: { data, _, _ in
                        DispatchQueue.global(qos: .utility).async {
                            do {
                                let jsonResult = try JSON.parse(jsonData: data!)
                                DispatchQueue.main.async {
                                    success?(jsonResult)
                                }
                            } catch {
                                DispatchQueue.main.async {
                                    failure?(error)
                                }
                            }
                        }
                    }
                )
            }
        } catch let error as NSError {
            // oops, error in converting it to JSON
            failure?(error)
        }
    }
}

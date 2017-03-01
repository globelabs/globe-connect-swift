import Foundation

public struct Sms {
    let accessToken: String
    let shortCode: String

    public typealias SuccessHandler = (JSON) -> Void
    public typealias ErrorHandler = (_ error: Error) -> Void

    public init(accessToken: String, shortCode: String) {
        self.accessToken = accessToken
        self.shortCode = shortCode
    }

    public func sendBinaryMessage(
        address: String,
        message: String,
        header: String,
        encoding: String? = nil,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let binarySmsURL = "https://devapi.globelabs.com.ph/binarymessaging/v1/outbound/\(self.shortCode)/requests?access_token=\(self.accessToken)"

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundBinaryMessageRequest" : [
                "userDataHeader"        : header,
                "dataCodingScheme"      : 1,
                "address"               : address,
                "senderAddress"         : self.shortCode,
                "access_token"          : self.accessToken,
                "outboundBinaryMessage" : [
                    "message" : message
                ]
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
                    url: binarySmsURL,
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

    public func sendMessage(
        address: String,
        message: String,
        clientCorrelator: String? = nil,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let sendMessageURL = "https://devapi.globelabs.com.ph/smsmessaging/v1/outbound/\(self.shortCode)/requests?access_token=\(self.accessToken)"

        // fix the address
        let address = "tel:" + address

        // fix the sender address
        let sender = "tel:" + self.shortCode

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundSMSMessageRequest" : [
                "senderAddress"           : sender,
                "address"                 : [address],
                "outboundSMSTextMessage"  : [
                    "message" : message
                ]
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
                // now, let's send it!
                Request().post(
                    url: sendMessageURL,
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

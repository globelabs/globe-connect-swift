import Foundation

struct Payment {
    let accessToken: String
    let appId: String
    let appSecret: String

    typealias SuccessHandler = (JSON) -> Void
    typealias ErrorHandler = (_ error: Error) -> Void

    public init(
        appId: String,
        appSecret: String,
        accessToken: String? = nil
    ) {
        self.appId          = appId
        self.appSecret      = appSecret
        self.accessToken    = accessToken!
    }

    public func sendPaymentRequest(
        amount: Float,
        description: String,
        endUserId: String,
        referenceCode: String,
        transactionOperationStatus: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) {
        // set the url
        let url = "https://devapi.globelabs.com.ph/payment/v1/transactions/amount?access_token=\(self.accessToken)"

        // TODO: make sure that amount has 2 decimal places

        let data: [String: Any] = [
            "amount"                      : String(format: "%.2f", amount),
            "description"                 : description,
            "endUserId"                   : endUserId,
            "referenceCode"               : referenceCode,
            "transactionOperationStatus"  : transactionOperationStatus
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

    public func getLastReferenceCode(
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let url = "https://devapi.globelabs.com.ph/payment/v1/transactions/getLastRefCode?app_id=\(self.appId)&app_secret=\(self.appSecret)"

        // set the header
        let headers = [
            "Content-Type" : "application/json; charset=utf-8"
        ]

        // send the request
        Request().get(
            url: url,
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
}

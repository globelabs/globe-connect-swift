import Foundation

struct Amax {
    let appId: String
    let appSecret: String

    typealias SuccessHandler = (JSON) -> Void
    typealias ErrorHandler = (_ error: Error) -> Void

    public init(appId: String, appSecret: String) {
        self.appId      = appId;
        self.appSecret  = appSecret
    }

    public func sendRewardRequest(
        address: String,
        promo: String,
        rewardsToken: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) {
        // set the url
        let url = "https://devapi.globelabs.com.ph/rewards/v1/transactions/send"

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundRewardRequest" : [
                "app_id"        : self.appId,
                "app_secret"    : self.appSecret,
                "rewards_token" : rewardsToken,
                "address"       : address,
                "promo"         : promo
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

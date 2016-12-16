import Foundation

struct Authentication {
    typealias SuccessHandler = (JSON) -> Void
    typealias ErrorHandler = (_ error: Error) -> Void

    public func getAccessToken(
        appId: String,
        appSecret: String,
        code: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        let accessTokenURL = "https://developer.globelabs.com.ph/oauth/access_token"

        // build out the payload to be sent
        let parameters: [String : String] = [
            "app_id": appId,
            "app_secret": appSecret,
            "code": code
        ]

        // build out the payload
        var body: String = ""
        for (key, value) in parameters {
            body = body.appending(key)
            body = body.appending("=")
            body = body.appending(value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            body = body.appending("&")
        }

        // set the header
        let headers = [
            "Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"
        ]

        // send the request
        Request().post(
            url: accessTokenURL,
            payload: body,
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

    public func getDialogUrl(appId: String) -> String {
        let redirectUrl: String = "https://developer.globelabs.com.ph/dialog/oauth?app_id=\(appId)"

        return redirectUrl
    }
}

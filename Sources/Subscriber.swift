import Foundation

public struct Subscriber {
    let accessToken: String

    typealias SuccessHandler = (JSON) -> Void
    typealias ErrorHandler = (_ error: Error) -> Void

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    func getSubscriberBalance(
        address: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let url = "https://devapi.globelabs.com.ph/location/v1/queries/balance?access_token=\(self.accessToken)&address=\(address)"

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

    func getSubscriberReloadAmount(
        address: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let url = "https://devapi.globelabs.com.ph/location/v1/queries/reload_amount?access_token=\(self.accessToken)&address=\(address)"

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

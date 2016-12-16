import Foundation

struct Request {
    typealias RequestCallback = ((Data?, Any?, Any?) -> ())

    func get(
        url: String,
        payload: String? = nil,
        headers: [String: String]?,
        callback: @escaping RequestCallback
    ) {
        // build out the request
        var request = URLRequest(url: URL(string: url)!)

        // set the request method
        request.httpMethod = "GET"

        // check if there are given headers
        if headers != nil {
            // loop
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        // send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            callback(data, response, error)
        }

        task.resume();
    }

    func post(
        url: String,
        payload: String,
        headers: [String: String]?,
        callback: @escaping RequestCallback
    ) {
        // build out the request
        var request = URLRequest(url: URL(string: url)!)

        // set the request method
        request.httpMethod = "POST"

        // check if there are given headers
        if headers != nil {
            // loop
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        // set the request body and convert the data to UTF-8
        request.httpBody = payload.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // return whatever
            callback(data, response, error)
        }

        task.resume();
    }
}

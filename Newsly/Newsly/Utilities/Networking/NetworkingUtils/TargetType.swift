//
//  TargetType.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

protocol TargetType {
    var baseUrl: String {get}
    var path: String {get}
    var method: HttpMethod {get}
    var headers: [String: String] {get}
    var params: Requestparams {get}
}

extension TargetType {
    
    func asUrlRequest() throws -> URLRequest {
        let url = try baseUrl.asUrl()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        switch params {
        case .query(let request):
            let params = try request?.toDictionary()
            let queryItems = params?.compactMap({URLQueryItem(name: $0.key, value: "\($0.value)")})
            var urlComponent = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            urlComponent?.queryItems = queryItems
            urlRequest.url = urlComponent?.url
        case .body(let request):
            let params = try request?.toDictionary()
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        urlRequest.logCURL(pretty: true)
        return urlRequest
    }
}

extension URLRequest {
    @discardableResult
    func logCURL(pretty: Bool = false) -> String {
        print("============= cURL ============= \n")
        
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key, value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8), !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        print(cURL)
        return cURL
    }
}

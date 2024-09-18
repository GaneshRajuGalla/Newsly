//
//  APIClient.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

class APIClient {
    
    // MARK: - Properties
    private static let decoder:JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private static let successrange:Range = 200..<300
    
    
    // MARK: - Methods
    static func sendRequest<T: Decodable>(endPoint: EndPointType) async throws -> T {
        let (data,response) = try await session.data(for: endPoint.asUrlRequest())
        let validData = try validat(data: data, response: response)
        return try decoder.decode(T.self, from: validData)
    }
    
    
    // Function to validate the status code
    static private func validat(data:Data, response:URLResponse) throws -> Data {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        if successrange.contains(code) {
            return data
        }else{
            switch code{
            case 401:
                throw NetworkError.unAuthorized
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.unExpectedError(code)
            }
        }
    }
}

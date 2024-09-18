//
//  NetworkError.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidUrl
    case encodingError
    case invalidResponse
    case unAuthorized
    case notFound
    case unExpectedError(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "The URL provided was invalid."
        case .encodingError:
            return "Failed to encode the request data."
        case .invalidResponse:
            return "The response from the server was invalid."
        case .unAuthorized:
            return "You are not authorized to perform this action."
        case .notFound:
            return "The requested resource was not found."
        case .unExpectedError(let statusCode):
            return "An unexpected error occurred with status code \(statusCode)."
        }
    }
}

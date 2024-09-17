//
//  HttpHeaderKeys.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

enum HttpHeaderKeys: String {
    case authentication = "Authorization"
    case acceptType = "accept"
    case contentType = "Content-Type"
}

enum HttpHeaderValues: String {
    case json = "Application/json"
}

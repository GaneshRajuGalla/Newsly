//
//  EndPointType.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

enum EndPointType {
    case getNews(NewsQuery)
}

extension EndPointType: TargetType {
    
    var baseUrl: String {
        return "https://newsapi.org"
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/v2/top-headlines"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .getNews:
            return [
                HttpHeaderKeys.contentType.rawValue : HttpHeaderValues.json.rawValue,
                HttpHeaderKeys.acceptType.rawValue : HttpHeaderValues.json.rawValue
            ]
        }
    }
     
    var params: Requestparams {
        switch self {
        case .getNews(let request):
            return .query(request)
        }
    }
}

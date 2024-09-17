//
//  NewsQuery.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

struct NewsQuery: Codable {
    let country: String
    let category: String
    let apiKey: String
}

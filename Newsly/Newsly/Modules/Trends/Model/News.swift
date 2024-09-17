//
//  News.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

// MARK: - News
struct News: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}

// MARK: - Article
struct Article: Codable, Identifiable {
    var id: UUID = .init()
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage 
        case publishedAt
        case content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

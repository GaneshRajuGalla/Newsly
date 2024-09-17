//
//  TrendsViewModel.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

final class TrendsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var categoryArticles: [String: [Article]] = [
        "business": [],
        "entertainment": [],
        "general": [],
        "health": [],
        "science": [],
        "sports": [],
        "technology": []
    ]
    
    @Published var selectedCategories: [String] = []
}

// MARK: - Helpers
extension TrendsViewModel {
    
    func getHeadlines() async {
        for category in selectedCategories {
            do {
                let query = NewsQuery(country: "us", category: category, apiKey: apiKey)
                if let news: News = try await APIClient.sendRequest(endPoint: .getNews(query)),
                   let articles = news.articles {
                    Task { @MainActor in
                        self.categoryArticles[category] = articles
                    }
                }
            } catch {
                print("Error fetching articles for category \(category):", error)
            }
        }
    }
    
    func hasArticles(for category: String) -> Bool {
        return !(categoryArticles[category]?.isEmpty ?? true)
    }
}

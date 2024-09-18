//
//  TrendsViewModel.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation
import SwiftUI

@MainActor
final class TrendsViewModel: ObservableObject {
    
    // MARK: - Properties
    var categoryArticles: [String: [Article]] = [:]
    let categories: [String] = ["business", "entertainment", "general", "health", "science", "sports", "technology"] 
    
    @Published var viewState: ViewState<[String: [Article]]> = .initial
    @Published var selectedCategories: [String] = []
    @AppStorage("isGrid") var isGrid: Bool = false
    @Published var showFavorite: Bool = false
    @Published var searchText = "" {
           didSet {
               filterArticlesBySearchText()
           }
       }
    
    init() {
        selectedCategories = categories
        Task {
            await getArticles()
        }
    }
}

// MARK: - Helpers
extension TrendsViewModel {
    
    func getArticles() async {
        viewState = .fetching
        var fetchedArticles: [String: [Article]] = [:]
        do {
            try await withThrowingTaskGroup(of: (String, [Article]).self) { group in
                for category in selectedCategories {
                    group.addTask {
                        let query = NewsQuery(country: "us", category: category, apiKey: apiKey)
                        let news: News = try await APIClient.sendRequest(endPoint: .getNews(query))
                        let articles = news.articles ?? []
                        return (category, articles)
                    }
                }
                for try await (category, articles) in group {
                    fetchedArticles[category] = articles
                }
            }
            if fetchedArticles.values.allSatisfy({ $0.isEmpty }) {
                viewState = .empty
            } else {
                self.categoryArticles = fetchedArticles
                viewState = .success(fetchedArticles)
            }
        } catch {
            viewState = .failure(error)
        }
    }
    
    func hasArticles(articles:[String: [Article]],for category: String) -> Bool {
        return !(articles[category]?.isEmpty ?? true)
    }
    
    func toggleCategorySelection(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll { $0 == category }
        } else {
            selectedCategories.append(category)
        }
        filterArticles()
    }
    
    func filterArticles() {
        DispatchQueue.main.async {
            if self.selectedCategories.isEmpty {
                self.viewState = .empty
            } else {
                let filteredArticles = self.categoryArticles.filter { self.selectedCategories.contains($0.key) }
                self.viewState = .success(filteredArticles)
            }
        }
    }
    
    func filterArticlesBySearchText() {
        if searchText.isEmpty {
            viewState = .success(categoryArticles)
            return
        }
        
        let matchedArticles: [String: [Article]] = categoryArticles.mapValues { articles in
            articles.filter { article in
                article.title?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
        
        if matchedArticles.values.allSatisfy({ $0.isEmpty }) {
            viewState = .empty
        } else {
            viewState = .success(matchedArticles)
        }
    }
}

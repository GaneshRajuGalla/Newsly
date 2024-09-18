//
//  FavoriteView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import SwiftUI

struct FavoriteView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var manager: NavigationManager
    @EnvironmentObject private var persistanceManager: PersistenceManager
    
    // MARK: - body
    var body: some View {
        contentView
            .navigationTitle("Favourites")
            .navigationBarTitleDisplayMode(.inline)
            .navigation(path: $manager.favoriteRoutes)
    }
}

extension FavoriteView {
    
    @ViewBuilder
    private var contentView: some View {
        if !persistanceManager.favoriteArticles.isEmpty {
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(persistanceManager.favoriteArticles, id: \.id) { article in
                        let newArticle = Article(description: article.desp, title: article.title, url: article.url, urlToImage: article.urlToImage)
                        ArticleCardView(article: newArticle, isGrid: .constant(false))
                            .onTapGesture {
                                if let url = article.url {
                                    manager.push(to: .detail(url))
                                }
                            }
                    }
                }
            }
        } else {
            ContentNotavailableView(contentType: .noFavorites)
        }
    }
}

#Preview {
    FavoriteView()
}

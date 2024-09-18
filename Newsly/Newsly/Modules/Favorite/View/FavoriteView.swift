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
    @State private var isGrid: Bool = false
    
    // MARK: - body
    var body: some View {
        contentView
            .navigationTitle("Favourites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.grid.2x2")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(isGrid ? Color("AccentColor") : .gray)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .navigation(path: $manager.favoriteRoutes)
    }
}

extension FavoriteView {
    
    @ViewBuilder
    private var contentView: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(persistanceManager.favoriteArticles, id: \.id) { article in
                    let newArticle = Article(description: article.desp, title: article.title, url: article.url, urlToImage: article.urlToImage)
                    ArticleCardView(article: newArticle)
                        .onTapGesture {
                            if let url = article.url {
                                manager.push(to: .detail(url))
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    FavoriteView()
}

//
//  TrendsView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import SwiftUI

struct TrendsView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = TrendsViewModel()
    @EnvironmentObject private var manager: NavigationManager
    
    // MARK: - Body
    var body: some View {
        contentView
            .navigation(path: $manager.trendRoutes)
    }
}

extension TrendsView {
    
    @ViewBuilder
    private var contentView: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.selectedCategories, id: \.self) { category in
                    if viewModel.hasArticles(for: category) {
                        categorySection(for: category)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func categorySection(for category: String) -> some View {
        let articles = viewModel.categoryArticles[category] ?? []
        Section {
            let shouldLimitArticles = viewModel.selectedCategories.count > 1
            let displayedArticles = shouldLimitArticles ? Array(articles.prefix(10)) : articles
            ForEach(displayedArticles, id: \.id) { article in
                ArticleCardView(article: article)
                    .onTapGesture {
                        if let url = article.url {
                            manager.push(to: .detail(url))
                        }
                    }
            }
        } header: {
            Button {
                manager.push(to: .categoryView(category, articles))
            } label: {
                HStack {
                    Text(category.capitalized)
                        .textStyle(color: .white, font: .title2, weight: .bold)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20 ,height: 20)
                        .foregroundStyle(Color("AccentColor"))
                }
                .contentShape(Rectangle())
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    TrendsView()
        .preferredColorScheme(.dark)
}

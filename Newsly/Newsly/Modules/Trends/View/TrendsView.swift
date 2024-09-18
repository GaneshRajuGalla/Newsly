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
        VStack(spacing: 19){
            SearchBarWithButtonView(searchText: $viewModel.searchText, isGrid: $viewModel.isGrid, showFavorite: $viewModel.showFavorite)
            CategorySelectionView(viewModel: viewModel)
            Spacer()
            switch viewModel.viewState {
            case .initial, .fetching:
                Loader()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .success(let articles):
                contentView(articles: articles)
            case .failure(let error):
                ContentNotavailableView(contentType: .errorOccurred(error.localizedDescription, retryCallback: {
                    Task {
                        await viewModel.getArticles()
                    }
                }))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .empty:
                ContentNotavailableView(contentType: .noDataAvailable)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onChange(of: viewModel.isGrid) { value in
            // grid logic will come here
        }
        .onChange(of: viewModel.showFavorite){ value in
            if value {
                manager.selectedTab = .favorite
            }
        }
        .navigation(path: $manager.trendRoutes)
    }
}

extension TrendsView {
    
    @ViewBuilder
    private func contentView(articles:[String: [Article]]) -> some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.selectedCategories, id: \.self) { category in
                    if viewModel.hasArticles(articles: articles, for: category) {
                        categorySection(categoryArticles: articles, for: category)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func categorySection(categoryArticles:[String: [Article]],for category: String) -> some View {
        let articles = categoryArticles[category] ?? []
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

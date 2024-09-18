//
//  ArticleCardView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleCardView: View {
    
    // MARK: - Properties
    let article: Article
    @EnvironmentObject private var persistanceManager: PersistenceManager
    
    // MARK: - Body
    var body: some View {
        contentView
    }
}

extension ArticleCardView {
    
    @ViewBuilder
    private var contentView: some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack {
                Rectangle()
                    .fill(Color("AccentColor"))
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    WebImage(url: url)
                        .resizable()
                        .indicator(.activity)
                        .frame(width: 118, height: 118)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
            }
            .overlay(alignment: .topLeading) {
                Button {
                    guard let url = article.url else {
                        return
                    }
                    if persistanceManager.isArticleFavorite(url: url) {
                        persistanceManager.removeArticle(url: url)
                    } else {
                        persistanceManager.addArticle(title: article.title ?? "", desp: article.description ?? "", url: article.url ?? "", urlToImage: article.urlToImage ?? "")
                    }
                } label: {
                    let isFavorite = persistanceManager.isArticleFavorite(url: article.url ?? "")
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.yellow)
                }
                .padding(.all)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(article.title ?? "--")
                    .textStyle(color: .white, font: .subheadline, weight: .bold, alignment: .leading)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text(article.description ?? "--")
                    .textStyle(color: .gray, font: .caption, alignment: .leading)
                    .lineLimit(4)
                    .truncationMode(.tail)
            }
            .padding(.vertical, 5)
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 120)
        .background(Color("background"))
        .cornerRadius(20)
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ArticleCardView(article: Article(source: Source(id: "", name: ""), author: "", title: "Sample Title", description: "Sample description for the article goes here.", url: "", urlToImage: "", publishedAt: "", content: ""))
}

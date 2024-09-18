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
    @Binding var isGrid: Bool
    
    // MARK: - Body
    var body: some View {
        contentView
    }
}

extension ArticleCardView {
    
    @ViewBuilder
    private var contentView: some View {
        if isGrid {
            verticalLayout
        } else {
            horizontalLayout
        }
    }
    
    private var horizontalLayout: some View {
        HStack(alignment: .top, spacing: 10) {
            imageView
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
    }
    
    private var verticalLayout: some View {
        VStack(spacing: 10) {
            imageView
            VStack(alignment: .leading, spacing: 0) {
                Text(article.title ?? "--")
                    .textStyle(color: .white, font: .subheadline, weight: .bold, alignment: .leading)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text(article.description ?? "--")
                    .textStyle(color: .gray, font: .caption, alignment: .leading)
                    .lineLimit(2)
                    .truncationMode(.tail)
            }
            .padding(.horizontal, 5)
            Spacer()
        }
        .frame(width: 150, height: 220)
        .background(Color("background"))
        .cornerRadius(20)
    }
    
    private var imageView: some View {
        ZStack {
            Rectangle()
                .fill(Color("AccentColor"))
                .frame(width: isGrid ? 150 : 120, height: isGrid ? 150 : 120)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                WebImage(url: url)
                    .resizable()
                    .indicator(.activity)
                    .frame(width: isGrid ? 150 : 120, height: isGrid ? 150 : 120)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
        .overlay(favoriteButton, alignment: .topLeading)
    }
    
    private var favoriteButton: some View {
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
                .frame(width: 25, height: 25)
                .foregroundStyle(.pink)
        }
        .padding(.all)
    }
}

#Preview {
    ArticleCardView(
        article: Article(source: Source(id: "", name: ""), author: "", title: "Sample Title", description: "Sample description for the article goes here.", url: "", urlToImage: "", publishedAt: "", content: ""),
        isGrid: .constant(true)
    )
}

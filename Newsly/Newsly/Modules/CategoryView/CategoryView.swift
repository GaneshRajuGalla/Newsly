//
//  CategoryView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import SwiftUI

struct CategoryView: View {
    
    // MARK: - Properties
    let category: String
    let articles:[Article]
    @EnvironmentObject private var manager: NavigationManager
    
    init(category: String, articles: [Article]) {
        self.category = category
        self.articles = articles
    }
    
    // MARK: - Body
    var body: some View {
        contentView
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden(true)
            .navigationTitle(category.capitalized)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        manager.popLast()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20 ,height: 20)
                            .foregroundStyle(Color("AccentColor"))
                        
                    })
                }
            }
            .modifier(BackToView {
                manager.popLast()
            })
    }
}

extension CategoryView {
    
    @ViewBuilder
    private var contentView: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(articles, id: \.id) { article in
                    ArticleCardView(article: article)
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

//#Preview {
//    CategoryView()
//}

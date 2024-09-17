//
//  NavigationModifier.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation
import SwiftUI

struct NavigationModifier: ViewModifier {
    
    @Binding var route: [Routes]
    
    @ViewBuilder
    fileprivate func coordinator(route: Routes) -> some View{
        switch route {
        case .categoryView(let category, let articles):
            CategoryView(category: category, articles: articles)
        case .detail(let urlString):
            DetailView(urlString: urlString)
        }
    }
    
    
    func body(content: Content) -> some View {
        NavigationStack(path: $route) {
            content
                .navigationDestination(for: Routes.self) { route in
                    coordinator(route: route)
                }
        }
    }
}



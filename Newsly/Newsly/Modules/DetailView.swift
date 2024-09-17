//
//  DetailView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import SwiftUI
import WebKit

struct DetailView: View {
    
    // MARK: - Properties
    let urlString: String
    @EnvironmentObject private var manager: NavigationManager
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    // MARK: - Body
    var body: some View {
        if let url = URL(string: urlString) {
            WebView(url: url)
                .edgesIgnoringSafeArea(.all)
                .toolbar(.hidden, for: .tabBar)
                .navigationBarBackButtonHidden(true)
                .modifier(BackToView {
                    manager.popLast()
                })
        }
    }
}

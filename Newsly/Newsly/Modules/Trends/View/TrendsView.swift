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
    
    // MARK: - Body
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                viewModel.selectedCategories.append("business")
                await viewModel.getHeadlines()
            }
    }
}

#Preview {
    TrendsView()
}

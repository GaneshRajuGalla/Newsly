//
//  CategorySelectionView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 18/09/24.
//

import SwiftUI

struct CategorySelectionView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: TrendsViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.categories, id: \.self) { category in
                    CategoryChipView(category: category, isSelected: viewModel.selectedCategories.contains(category)) {
                        withAnimation {
                            viewModel.toggleCategorySelection(category)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryChipView: View {
    let category: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Text(category.capitalized)
            .font(.subheadline)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(isSelected ? Color("AccentColor") : Color("background"))
            .foregroundColor(isSelected ? Color.black : Color("AccentColor"))
            .cornerRadius(15)
            .onTapGesture {
                onTap()
            }
    }
}

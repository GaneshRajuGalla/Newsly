//
//  SearchBarView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 18/09/24.
//

import SwiftUI

struct SearchBarWithButtonView: View {
    
    // MARK: - Properties
    @Binding var searchText: String
    @Binding var isGrid:Bool
    @Binding var showFavorite:Bool
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 10){
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.gray.opacity(0.2))
                    .shadow(radius: 5, x: 2, y: 0)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                    
                    TextField("Search by Article", text: $searchText)
                        .textFieldStyle(.plain)
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
            .frame(height: 40)
            HStack(spacing: 10){
                Button {
                    withAnimation {
                        showFavorite.toggle()
                    }
                } label: {
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)
                }
                
                Button {
                    withAnimation {
                        isGrid.toggle()
                    }
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(isGrid ? Color("AccentColor") : .gray)
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    SearchBarWithButtonView(searchText: .constant(""), isGrid: .constant(false), showFavorite: .constant(false))
}

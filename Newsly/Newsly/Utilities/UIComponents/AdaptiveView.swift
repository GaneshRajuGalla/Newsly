//
//  AdaptiveView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 18/09/24.
//

import SwiftUI

struct AdaptiveView<Content: View>: View {
    
    // MARK: - Properties
    @Binding var isGrid: Bool
    let content: () -> Content
    
    // MARK: - Body
    var body: some View {
        Group {
            if isGrid {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 20) {
                        content()
                    }
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        content()
                    }
                }
            }
        }
    }
}

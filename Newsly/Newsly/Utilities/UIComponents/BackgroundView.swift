//
//  BackgroundView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    
    // MARK: - Properties
    var color: Color = Color.white
    var borderColor: Color = Color.gray
    var cornerRadius: CGFloat = 20
    var lineWidth: CGFloat = 1
  
    // MARK: - Body
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(color)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
    }
}

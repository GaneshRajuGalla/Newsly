//
//  TextStyleModifier.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation
import SwiftUI

struct TextStyleModifier: ViewModifier {
    let color: Color
    let font: Font
    let weight: Font.Weight
    let alignment: TextAlignment

    func body(content: Content) -> some View {
        content
            .font(font.weight(weight))
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .fixedSize(horizontal: false, vertical: true)
    }
}

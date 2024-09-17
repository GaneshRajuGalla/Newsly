//
//  View+Extension.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation
import SwiftUI

extension View {
    
    func navigation(path: Binding<[Routes]>) -> some View{
        self.modifier(NavigationModifier(route: path))
    }
    
    func textStyle(
        color: Color = .black,
        font: Font = .body,
        weight: Font.Weight = .regular,
        alignment: TextAlignment = .center) -> some View {
        self.modifier(TextStyleModifier(color: color, font: font, weight: weight, alignment: alignment))
    }
    
    var cardModifier: some View {
        self.modifier(CardModifier())
    }
}
    

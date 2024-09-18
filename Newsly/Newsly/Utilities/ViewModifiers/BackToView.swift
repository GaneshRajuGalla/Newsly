//
//  BackToView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//
import SwiftUI

struct BackToView: ViewModifier {
    let function: () -> Void
    
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onEnded { value in
                    let horizontalAmount = value.translation.width
                    let verticalAmount = value.translation.height
                    
                    if abs(horizontalAmount) > abs(verticalAmount) && horizontalAmount > 0 {
                        function()
                    }
                }
            )
    }
}

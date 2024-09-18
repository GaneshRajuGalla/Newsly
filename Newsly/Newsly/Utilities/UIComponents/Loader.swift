//
//  Loader.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 18/09/24.
//

import SwiftUI

struct Loader: View {
    
    // MARK: - Properties
    @State var animate:Bool = false
    
    // MARK: - Body
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.8)
            .stroke(AngularGradient(gradient: .init(colors: [Color("AccentColor"), Color("background")]),center: .center),
                style: StrokeStyle(lineWidth: 4.0,lineCap: .round,lineJoin:.round))
        .frame(width: 35,height: 35)
        .rotationEffect(.init(degrees: self.animate ? 360 : 0))
        .animation(.linear(duration: 0.7).repeatForever(autoreverses: false), value: animate)
        .padding(.all)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        }
        .onAppear {
            self.animate.toggle()
        }
    }
}



#Preview {
    Loader()
}

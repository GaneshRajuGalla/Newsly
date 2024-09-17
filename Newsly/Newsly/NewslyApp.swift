//
//  NewslyApp.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import SwiftUI

@main
struct NewslyApp: App {
    
    // MARK: - Properties
    @StateObject var manager:NavigationManager = .init()
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            TabBar()
                .preferredColorScheme(.dark)
                .environmentObject(manager)
        }
    }
}

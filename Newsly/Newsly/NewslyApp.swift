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
    @StateObject private var manager:NavigationManager = .init()
    @StateObject private var persistanceManager: PersistenceManager = PersistenceManager()
    @StateObject private var network = Network()
    
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            TabBar()
                .preferredColorScheme(.dark)
                .environmentObject(manager)
                .environmentObject(persistanceManager)
                .onReceive(network.$connected) { isConnected in
                    manager.selectedTab = isConnected ? .trends : .favorite
                }
        }
    }
}

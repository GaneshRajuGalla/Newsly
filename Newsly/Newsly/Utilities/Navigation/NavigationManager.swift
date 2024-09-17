//
//  NavigationManager.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation
import SwiftUI

class NavigationManager: ObservableObject{
    
    @Published var selectedTab:TabItems = .trends
    @Published var trendRoutes:[Routes] = []
    @Published var favoriteRoutes:[Routes] = []
    @Published var moreRoutes:[Routes] = []
    
    var tabSelection: Binding<TabItems> {
        Binding{ [weak self] in
            self?.selectedTab ?? .trends
        } set: { [weak self] newValue in
            self?.selectedTab = newValue
        }
    }
    
    func push(to route: Routes){
        switch selectedTab {
        case .trends:
            trendRoutes.append(route)
        case .favorite:
            favoriteRoutes.append(route)
        case .more:
            moreRoutes.append(route)
        }
    }
    
    func pop(to route: Routes){
        switch selectedTab {
        case .trends:
            trendRoutes.removeAll(where: {$0 == route})
        case .favorite:
            favoriteRoutes.removeAll(where: {$0 == route})
        case .more:
            moreRoutes.removeAll(where: {$0 == route})
        }
    }
    
    func popLast(){
        switch selectedTab {
        case .trends:
            trendRoutes.removeLast()
        case .favorite:
            favoriteRoutes.removeLast()
        case .more:
            moreRoutes.removeLast()
        }
    }
    
    func popToRoot(){
        switch selectedTab {
        case .trends:
            trendRoutes.removeAll()
        case .favorite:
            favoriteRoutes.removeAll()
        case .more:
            moreRoutes.removeAll()
        }
    }
}

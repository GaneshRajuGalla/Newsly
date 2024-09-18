//
//  TabBar.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation
import SwiftUI

struct TabBar: View {
    
    // MARK: - Properties
    @EnvironmentObject var manager: NavigationManager
    
    // MARK: - Body
    var body: some View {
        TabView(selection: manager.tabSelection) {
            TrendsView()
                .tabItem {
                    Image(systemName: TabItems.trends.image)
                    Text(TabItems.trends.title)
                }
                .tag(TabItems.trends)
            
            FavoriteView()
                .tabItem {
                    Image(systemName: TabItems.favorite.image)
                    Text(TabItems.favorite.title)
                }
                .tag(TabItems.favorite)
            
            MoreView()
                .tabItem {
                    Image(systemName: TabItems.more.image)
                    Text(TabItems.more.title)
                }
                .tag(TabItems.more)
        }
    }
}

#Preview {
    TabBar()
}

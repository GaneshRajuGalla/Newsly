//
//  TabItems.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

enum TabItems: Hashable, CaseIterable {
    
    case trends
    case favorite
    case more

    var title:String{
        switch self {
        case .trends:
            return "Trends"
        case .favorite:
            return "Favorite"
        case .more:
            return "More"
        }
    }
        
    var image:String{
        switch self {
        case .trends:
            return "list.bullet.rectangle.portrait"
        case .favorite:
            return "star"
        case .more:
            return "ellipsis"
        }
    }
}



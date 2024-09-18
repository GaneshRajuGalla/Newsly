//
//  Routes.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

enum Routes: Hashable, Equatable {
    
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: Routes, rhs: Routes) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    case categoryView(String, [Article])
    case detail(String)
}



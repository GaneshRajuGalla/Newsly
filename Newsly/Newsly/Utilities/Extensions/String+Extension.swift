//
//  String+Extension.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

extension String {
    
}
extension String {
    
    func asUrl() throws -> URL {
        guard let url = URL(string: self) else {
            throw NetworkError.invalidUrl
        }
        return url
    }
    
    var isEmptyOrWhitespace: Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
}

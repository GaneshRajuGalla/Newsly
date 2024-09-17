//
//  Encodable+Extension.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String:Any] {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            if let jsonData = try JSONSerialization.jsonObject(with: data) as? [String : Any]{
                return jsonData
            }
        } catch {
            throw NetworkError.encodingError
        }
        return [:]
    }
}


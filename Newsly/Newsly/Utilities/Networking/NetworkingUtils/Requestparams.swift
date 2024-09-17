//
//  Requestparams.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import Foundation

enum Requestparams {
    case body(_ request:Encodable?)
    case query(_ request:Encodable?)
}

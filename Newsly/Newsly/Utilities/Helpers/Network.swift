//
//  NetworkMonitor.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 18/09/24.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    @Published var isConnected: Bool = false
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
}

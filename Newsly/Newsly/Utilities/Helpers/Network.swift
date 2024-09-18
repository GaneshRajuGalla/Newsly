//
//  Network.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 18/09/24.
//

import Foundation
import Network


class Network: ObservableObject {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published private(set) var connected: Bool = false
    
    init() {
        checkConnection()
    }
    
    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.connected = true
                }
            } else {
                DispatchQueue.main.async {
                    self.connected = false
                }
            }
        }
        monitor.start(queue: queue)
    }
}

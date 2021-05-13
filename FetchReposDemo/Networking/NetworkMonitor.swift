//
//  NetworkMonitor.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 14/05/2021.
//

import Foundation
import Network
 
class NetMonitor {
    
    // MARK: - Properties
    
    static public let shared = NetMonitor()
    
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    
    public var hasConnection: Bool = true
    public var connectionType: ConnectionType = .wifi
 
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
 
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { path in
            print(path)
            self.hasConnection = path.status == .satisfied
            self.connectionType = self.checkConnectionTypeForPath(path)
        }
    }
 
    func stopMonitoring() {
        self.monitor.cancel()
    }
 
    func checkConnectionTypeForPath(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }
        return .unknown
    }
    
}

public enum ConnectionType {
    case wifi
    case ethernet
    case cellular
    case unknown
}

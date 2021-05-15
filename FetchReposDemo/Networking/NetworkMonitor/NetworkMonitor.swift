//
//  NetworkMonitor.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 14/05/2021.
//

import Foundation
import Network
import os.log
 
class NetMonitor {
    
    // MARK: - Properties
    
    static let shared = NetMonitor()
    
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    
    var hasConnection: Bool  { connectionType != .unknown }
    var connectionType: NetworkManager.ConnectionType = .wifi
    
    // MARK: - Initializers
 
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
 
    // MARK: - Methods
    
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.connectionType = self.checkConnectionTypeForPath(path)
            os_log(.info, log: .network, "Network access changed to: %@", self.connectionType.rawValue)
        }
    }
 
    func stopMonitoring() {
        self.monitor.cancel()
    }
 
    func checkConnectionTypeForPath(_ path: NWPath) -> NetworkManager.ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }
        else if path.usesInterfaceType(.other) {
            return .other
        }
        return .unknown
    }
    
}

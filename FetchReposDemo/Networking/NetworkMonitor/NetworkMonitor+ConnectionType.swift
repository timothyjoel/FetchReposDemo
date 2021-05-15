//
//  ConnectionType.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 14/05/2021.
//

import Foundation

extension NetworkManager {
    
    enum ConnectionType: String {
        case wifi
        case ethernet
        case cellular
        case other
        case unknown
    }
    
}

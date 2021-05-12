//
//  Ext+os_log.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import os.log
import Foundation

extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Network logs.
    static let network = OSLog(subsystem: subsystem, category: "network")
    /// View cycle logs.
    static let viewCycle = OSLog(subsystem: subsystem, category: "viewcycle")
    /// View cycle logs.
    static let view = OSLog(subsystem: subsystem, category: "view")
    
}

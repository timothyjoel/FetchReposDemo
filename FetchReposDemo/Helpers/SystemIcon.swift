//
//  Icons.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import Foundation

enum SystemIcon {
    
    case reload
    case user
    
    var name: String {
        
        switch self {
        case .reload:   return "arrow.clockwise"
        case .user:     return "person.crop.circle"
        }
        
    }
    
}

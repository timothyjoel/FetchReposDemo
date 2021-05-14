//
//  API.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import Foundation

enum API: String {
    
    case Bitbucket
    case Github
    
    var url: String {
        switch self {
        case .Bitbucket:    return "https://api.bitbucket.org/2.0/repositories?fields=values.name,values.owner,values.description"
        case .Github:       return "https://api.github.com/repositories"
        }
    }
    
}

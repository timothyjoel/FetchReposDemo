//
//  CustomImage.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import Foundation

enum CustomImage {
    
   case bitbucketLogo
   case githubLogo
    
    var name: String {
        switch self {
        case .bitbucketLogo:    return "bitbucketLogo"
        case .githubLogo:       return "githubLogo"
        }
    }
    
}

//
//  BitBucketRepositories.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import Foundation

// MARK: - BitbucketRepositories

struct BitbucketRepositories: Codable {
    let values: [BitBucketRepository]
}

// MARK: - Value

struct BitBucketRepository: Codable {
    let owner: BitBucketOwner
    let repositoryDescripton: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case owner
        case repositoryDescripton = "description"
        case name
    }
}

// MARK: - Owner

struct BitBucketOwner: Codable {
    let displayName: String
    let links: BitBucketLinks

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case links
    }
}

// MARK: - Links

struct BitBucketLinks: Codable {
    
    let avatar: BitBucketAvatar

    enum CodingKeys: String, CodingKey {
        case avatar
    }
}

// MARK: - Avatar

struct BitBucketAvatar: Codable {
    
    let href: String
    
}

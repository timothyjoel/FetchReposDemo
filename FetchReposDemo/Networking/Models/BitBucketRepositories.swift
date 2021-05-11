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
    let valueDescription, name: String

    enum CodingKeys: String, CodingKey {
        case owner
        case valueDescription = "description"
        case name
    }
}

// MARK: - Owner
struct BitBucketOwner: Codable {
    let displayName, uuid: String
    let links: BitBucketLinks
    let type: BitBucketTypeEnum
    let nickname: String?
    let accountID: String?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case uuid, links, type, nickname
        case accountID = "account_id"
        case username
    }
}

// MARK: - Links
struct BitBucketLinks: Codable {
    
    let linksSelf, html, avatar: BitBucketAvatar

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, avatar
    }
}

// MARK: - Avatar
struct BitBucketAvatar: Codable {
    
    let href: String
    
}

enum BitBucketTypeEnum: String, Codable {
    case team = "team"
    case user = "user"
}

//
//  GithubRepository.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import Foundation

// MARK: - GithubRepository

struct GithubRepository: Codable {

    let name: String
    let owner: GithubOwner
    let githubRepositoryDescription: String?

    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case githubRepositoryDescription = "description"
    }
    
}

// MARK: - GithubOwner

struct GithubOwner: Codable {
    
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
}

typealias GithubRepositories = [GithubRepository]


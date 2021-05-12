//
//  NetworkManager.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import Foundation
import os.log
import Network
import RxSwift
import Alamofire

class NetworkManager {
    
    typealias WebServiceResponse<T> = (T?, AFError?) -> Void
    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()
    
    private init() { }
    
    // MARK: - Methods
    
    public func fetchBitbucketRepositories(completion: @escaping WebServiceResponse<[RepositoryModel]>) {
        fetch(BitbucketRepositories.self, api: .Bitbucket) { [weak self] fetchedRepositories, error in
            let repositories = self?.getRepositoryModels(from: fetchedRepositories)
            completion(repositories, error)
        }
    }
    
    public func fetchGithubRepositories(completion: @escaping WebServiceResponse<[RepositoryModel]>) {
        fetch(GithubRepositories.self, api: .Github) { [weak self] fetchedRepositories, error in
            let repositories = self?.getRepositoryModels(from: fetchedRepositories)
            completion(repositories, error)
        }
    }

    // MARK: - Helpers
    
    private func fetch<T: Decodable>(_ data: T.Type, api: API, _ completion: @escaping WebServiceResponse<T>) {
        AF
        .request(api.url)
        .validate()
        .responseDecodable(of: data) { (response) in
            switch response.result {
            case .success(let fetchedResults):
                os_log(.default, log: .network, "Successfully fetched data from %@ ", api.rawValue)
                completion(fetchedResults, nil)
            case .failure(let error):
                os_log(.fault, log: .network, "Failed to fetch data for %@, an error occured: %@", api.rawValue, error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    private func getRepositoryModels(from repositories: BitbucketRepositories?) -> [RepositoryModel] {
        guard let repositories = repositories else { return [] }
        return repositories.values.map {
            RepositoryModel(name: $0.name, desc: $0.valueDescription, ownerName: $0.owner.displayName, avatarLink: $0.owner.links.avatar.href, isBitbucket: true)
        }
    }
    
    private func getRepositoryModels(from repositories: GithubRepositories?) -> [RepositoryModel] {
        guard let repositories = repositories else { return [] }
        return repositories.map {
            RepositoryModel(name: $0.name, desc: $0.githubRepositoryDescription, ownerName: $0.owner.login, avatarLink: $0.owner.avatarURL, isBitbucket: false)
        }
    }
    
}

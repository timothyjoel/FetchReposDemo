//
//  MainScreenViewModel.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import Foundation
import RxCocoa
import RxSwift

class MainScreenViewModel {
    
    // MARK: - Properties
    
    private let networkManager = NetworkManager.shared
    public var repositories: BehaviorRelay<[RepositoryModel]> = BehaviorRelay(value: [])
    
    
    // MARK: - Methods
    
    public func fetchRepositories() {
        let group = DispatchGroup()
        var repositories = [RepositoryModel]()
        
        group.enter()
        networkManager.fetchBitbucketRepositories { fechtedRepositories, error in
            guard error == nil else { print("handle error"); return }
            guard let fetchedRepositories = fechtedRepositories else { return }
            repositories.append(contentsOf: fetchedRepositories)
            group.leave()
        }
        
        group.enter()
        networkManager.fetchGithubRepositories { fechtedRepositories, error in
            guard error == nil else { print("handle error"); return }
            guard let fetchedRepositories = fechtedRepositories else { return }
            repositories.append(contentsOf: fetchedRepositories)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.repositories.accept(repositories)
        }

    }
    
}

//
//  MainScreenViewModel.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import Foundation
import RxCocoa
import RxSwift
import os.log

class RepositoriesListViewModel {
    
    // MARK: - Properties
    
    private let networkManager = NetworkManager.shared
    public var repositories: BehaviorRelay<[RepositoryModel]> = BehaviorRelay(value: [])
    public var status: BehaviorRelay<LoaderIndicatorStatus> = BehaviorRelay(value: .loading)
    private var disposeBag = DisposeBag()
    
    
    // MARK: - Methods
    
    public func fetchRepositories() {
        set(status: .loading)
        
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
        
        group.notify(queue: .main) { [weak self] in
            self?.repositories.accept(repositories)
            self?.set(status: .loaded)
        }

    }
    
    private func set(status: LoaderIndicatorStatus) {
        os_log(.info, log: .view, "Setting status: %@", status.text)
        self.status.accept(status)
    }
    
}

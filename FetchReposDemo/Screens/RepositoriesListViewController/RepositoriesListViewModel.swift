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
    
    private var unsortedRepositories: [RepositoryModel] = []
    private var sortedRepositories: [RepositoryModel] = []
    private var disposeBag = DisposeBag()
    
    public var repositories: BehaviorRelay<[RepositoryModel]> = BehaviorRelay(value: [])
    public var sorted: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    public var status: BehaviorRelay<LoaderIndicatorStatus> = BehaviorRelay(value: .loading)
    
    
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
            guard let self = self else { return }
            self.unsortedRepositories = repositories
            self.sortedRepositories = repositories.sorted(by: { $0.name < $1.name })
            self.repositories.accept(self.sorted.value ? self.sortedRepositories : self.unsortedRepositories)
            self.set(status: .loaded)
        }

    }
    
    public func toggleSortOption() {
        sorted.accept(!sorted.value)
    }
    
    public func setRepositories(_ sorted:  Bool) {
        os_log(.info, log: .view, "Sorting repositories by name: %@", "\(sorted)")
        repositories.accept(sorted ? sortedRepositories : unsortedRepositories)
    }
    
    private func set(status: LoaderIndicatorStatus) {
        os_log(.info, log: .view, "Setting status: %@", status.text)
        self.status.accept(status)
    }
    
}

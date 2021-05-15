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
    
    var title = "Repositories"
    var sortText = ("Sort", "Unsort")
    var repositories: BehaviorRelay<[RepositoryModel]> = BehaviorRelay(value: [])
    var sorted: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var status: BehaviorRelay<LoaderIndicatorStatus> = BehaviorRelay(value: .loading)
    
    
    // MARK: - Methods
    
    func fetchRepositories() {
        guard NetMonitor.shared.hasConnection else { set(status: .noInternetConnection); return }
        set(status: .loading)
        let group = DispatchGroup()
        var repositories = [RepositoryModel]()
        
        group.enter()
        networkManager.fetchBitbucketRepositories { fechtedRepositories, error in
            guard error == nil else { return }
            guard let fetchedRepositories = fechtedRepositories else { return }
            repositories.append(contentsOf: fetchedRepositories)
            group.leave()
        }
        
        group.enter()
        networkManager.fetchGithubRepositories { fechtedRepositories, error in
            guard error == nil else { return }
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
    
    func toggleSortOption() {
        sorted.accept(!sorted.value)
        setRepositories(sorted.value)
    }
    
    private func setRepositories(_ sorted:  Bool) {
        os_log(.info, log: .view, "Sort repositories by name: %@", "\(sorted)")
        repositories.accept(sorted ? sortedRepositories : unsortedRepositories)
    }
    
    private func set(status: LoaderIndicatorStatus) {
        os_log(.info, log: .view, "Set Repositories list status to: %@", status.text)
        self.status.accept(status)
    }
    
}

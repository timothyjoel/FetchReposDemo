//
//  Coordinator.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 15/05/2021.
//

import Foundation
import UIKit

protocol RepositoriesListCoordinatorProtocol: Coordinator {
    func handleEvent(_ event: RepositoriesListCoordinatorEvent)
    func show(_ repository: RepositoryModel)
}

protocol CoordinatingRepositoriesList {
    var coordinator: RepositoriesListCoordinator? { get set }
}

enum RepositoriesListCoordinatorEvent {
    indirect case selected(RepositoryModel)
}

class RepositoriesListCoordinator: RepositoriesListCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    
    func handleEvent(_ event: RepositoriesListCoordinatorEvent) {
        switch event {
        case .selected(let repository): show(repository)
        }
    }
    
    func start() {
        let vm = RepositoriesListViewModel()
        let vc: RepositoriesListViewController = RepositoriesListViewController(vm: vm)
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func show(_ repository: RepositoryModel) {
        let vm = RepositoryDetailsViewModel(repository: repository)
        let vc = RepositoryDetailsViewController(vm: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

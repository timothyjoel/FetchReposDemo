//
//  MainViewController.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski.
//

import UIKit
import RxCocoa
import RxSwift

class RepositoriesListViewController: UIViewController {
    
    // MARK: - Properties
    private var vm: RepositoriesListViewModel
    private var mainScreenView = RepositoriesListView()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    
    init(vm: RepositoriesListViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setBindings()
        vm.fetchRepositories()
    }
    
    // MARK: - Setup
    
    private func setNavigationBar() {
        title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
    }
    
    private func setBindings() {
        observeRepositories()
        observeRepositorySelection()
        observeStatus()
    }
    
    private func observeRepositories() {
        vm.repositories
            .asDriver()
            .drive(mainScreenView.tableView.rx.items(cellIdentifier: RepositoryListTableViewCell.id, cellType: RepositoryListTableViewCell.self)) { row , repository, cell in
                cell.set(with: repository)
        }.disposed(by: disposeBag)
    }
    
    private func observeStatus() {
        vm.status.asDriver().skip(1).drive(onNext: { [weak self] status in
            self?.mainScreenView.set(for: status)
        }).disposed(by: disposeBag)
    }
    
    private func observeRepositorySelection() {
        mainScreenView.tableView.rx.modelSelected(RepositoryModel.self).subscribe(onNext: { [weak self] repository in
            let vm = RepositoryDetailsViewModel(repository: repository)
            let vc = RepositoryDetailsViewController(vm: vm)
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    
    @objc private func refreshTapped() {
        vm.fetchRepositories()
    }

}

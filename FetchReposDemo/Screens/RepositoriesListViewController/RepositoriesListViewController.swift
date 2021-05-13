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
    private var contentView = RepositoriesListView()
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
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setBindings()
        vm.fetchRepositories()
    }
    
    // MARK: - Setup
    
    private func setNavigationBar() {
        title = vm.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Unsort", style: .done, target: self, action: #selector(sortTapped))
    }
    
    private func setBindings() {
        observeRepositories()
        observeRepositorySelection()
        observeStatus()
        observeSortOption()
    }
    
    private func observeRepositories() {
        vm.repositories
            .asDriver()
            .drive(contentView.tableView.rx.items(cellIdentifier: RepositoryListTableViewCell.id, cellType: RepositoryListTableViewCell.self)) { row , repository, cell in
                cell.set(with: repository)
        }.disposed(by: disposeBag)
    }
    
    private func observeStatus() {
        vm.status.asDriver().skip(1).drive(onNext: { [weak self] status in
            self?.contentView.set(for: status)
        }).disposed(by: disposeBag)
    }
    
    private func observeSortOption() {
        vm.sorted.asDriver().drive(onNext: { [weak self] sorted in
            self?.vm.setRepositories(sorted)
            self?.navigationItem.leftBarButtonItem?.title = sorted ? "Unsort" : "Sort"
        }).disposed(by: disposeBag)
    }
    
    private func observeRepositorySelection() {
        contentView.tableView.rx.modelSelected(RepositoryModel.self).subscribe(onNext: { [weak self] repository in
            let vm = RepositoryDetailsViewModel(repository: repository)
            let vc = RepositoryDetailsViewController(vm: vm)
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    
    @objc private func refreshTapped() {
        vm.fetchRepositories()
    }
    
    @objc private func sortTapped() {
        vm.toggleSortOption()
    }

}

//
//  MainViewController.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    private var vm: MainScreenViewModel
    private var mainScreenView = MainScreenView()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    
    init(vm: MainScreenViewModel) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Setup
    
    private func setNavigationBar() {
        title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
    }
    
    // MARK: - Methods
    
    private func setBindings() {
        setRepositories()
        setOnRepositorySelection()
    }
    
    private func setRepositories() {
        vm.repositories
            .asDriver()
            .drive(mainScreenView.tableView.rx.items(cellIdentifier: MainScreenTableViewCell.id, cellType: MainScreenTableViewCell.self)) { row , repository, cell in
                cell.set(with: repository)
        }.disposed(by: disposeBag)
    }
    
    private func setOnRepositorySelection() {
        mainScreenView.tableView.rx.modelSelected(RepositoryModel.self).subscribe(onNext: { [weak self] repository in
            print(repository.name)
            let vc = DetailsViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    @objc private func refreshTapped() {
        vm.fetchRepositories()
    }

}

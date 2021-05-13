//
//  DetailsViewController.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var vm: RepositoryDetailsViewModel
    
    // MARK: -  Outlets
    
    private let contentView = RepositoryDetailsView()
    
    // MARK: - Initializers
    
    init(vm: RepositoryDetailsViewModel) {
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
        contentView.set(for: vm.repository)
    }

}

//
//  DetailsViewController.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    
    var vm: RepositoryDetailsViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    init(vm: RepositoryDetailsViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

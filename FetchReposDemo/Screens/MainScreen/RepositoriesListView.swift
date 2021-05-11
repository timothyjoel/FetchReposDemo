//
//  MainScreenView.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import UIKit

protocol ConfigurableLayout {
    func setUI()
    func setSubviews()
    func setConstraints()
}

class RepositoriesListView: UIView, ConfigurableLayout {
    
    // MARK: - Properties
    
    public lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.register(RepositoryListTableViewCell.self, forCellReuseIdentifier: RepositoryListTableViewCell.id)
        return $0
    }(UITableView())
    
    // MARK: - Initalizers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setUI() {
        backgroundColor = .systemBackground
        setSubviews()
        setConstraints()
    }
    
    func setSubviews() {
        addSubview(tableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

extension RepositoriesListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}

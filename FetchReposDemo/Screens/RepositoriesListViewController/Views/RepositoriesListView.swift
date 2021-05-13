//
//  MainScreenView.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import UIKit

class RepositoriesListView: UIView {
    
    // MARK: - Outlets
    
    public lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.register(RepositoryListTableViewCell.self, forCellReuseIdentifier: RepositoryListTableViewCell.id)
        return $0
    }(UITableView())
    
    private lazy var loaderIndicatorView = LoaderIndicatorView()
    
    // MARK: - Initalizers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUI() {
        backgroundColor = .systemBackground
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        addSubviews(tableView, loaderIndicatorView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            loaderIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            loaderIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loaderIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loaderIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Methods
    
    public func set(for status: LoaderIndicatorStatus) {
        loaderIndicatorView.isHidden = status == .loaded
        tableView.isHidden = status != .loaded
        loaderIndicatorView.set(for: status)
    }
    
}

extension RepositoriesListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        RepositoryListTableViewCell.defaultHeight
    }
    
}

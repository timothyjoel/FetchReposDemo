//
//  LoaderIndicatorView.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 12/05/2021.
//

import UIKit

class LoaderIndicatorView: UIView {
    
    // MARK: - Properties
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.style = .large
        $0.color = .systemPink
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var statusImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .systemPink
        $0.backgroundColor = .systemBackground
        return $0
    }(UIImageView())
    
    private lazy var statusLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.textColor = .systemPink
        $0.backgroundColor = .systemBackground
        $0.text = "asdasd"
        return $0
    }(UILabel())
    
    
    // MARK: - Initializiers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    
    private func setupUI() {
        setView()
        setSubviews()
        setConstraints()
    }
    
    private func setView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
    }
    
    private func setSubviews() {
        addSubviews(activityIndicator, statusLabel, statusImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            statusImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusImage.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -10),
            statusImage.widthAnchor.constraint(equalToConstant: 50),
            statusImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -10)
        ])
    }
    
    // MARK: - Methods
    
    public func set(for status: LoaderIndicatorStatus) {
        setLabel(for: status)
        setImage(for: status)
        setActivtyIndicator(for: status)
    }
    
    // MARK: - Helpers
    
    private func setLabel(for status: LoaderIndicatorStatus) {
        statusLabel.text = status.text
    }
    
    private func setActivtyIndicator(for status: LoaderIndicatorStatus) {
        status == .loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        activityIndicator.isHidden = status != .loading
    }
    
    private func setImage(for status: LoaderIndicatorStatus) {
        statusImage.isHidden = status == .loading
        statusImage.image = UIImage(systemIcon: status == .noInternetConnection ? .noInternet : .correct)
    }
    
}

public enum LoaderIndicatorStatus {
    case loading
    case loaded
    case noInternetConnection
    
    var text: String {
        switch self {
        case .loaded: return "Loaded"
        case .loading: return "Loading..."
        case .noInternetConnection: return "Failed to load repositories\nCheck your internet connection"
        }
    }
}

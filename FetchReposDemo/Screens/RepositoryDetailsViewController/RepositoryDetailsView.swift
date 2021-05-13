//
//  RepositoryDetailsView.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import UIKit
import SDWebImage

class RepositoryDetailsView: UIView {
    
    // MARK: - Properties
    
    private let imageSize: CGFloat = UIScreen.main.bounds.width
    private let padding: CGFloat = 16
    private let placeholderImage = UIImage(systemIcon: .user)?.withRenderingMode(.alwaysTemplate)
    
    // MARK: - Outlets
    
    private lazy var ownerImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = placeholderImage
        $0.tintColor = .systemPink
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var labelsStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private lazy var ownerNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .label
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var repositoryNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .label
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var repositoryDescLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .label
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func set(for repository: RepositoryModel) {
        ownerImageView.sd_setImage(with: URL(string: repository.avatarLink), placeholderImage: placeholderImage)
        ownerNameLabel.text = repository.ownerName
        repositoryNameLabel.text = "\(repository.name)\nby"
        repositoryDescLabel.text = repository.desc
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .systemBackground
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        addSubviews(ownerImageView, labelsStackView)
        labelsStackView.addArrangedSubviews(repositoryNameLabel, ownerNameLabel, repositoryDescLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ownerImageView.topAnchor.constraint(equalTo: topAnchor),
            ownerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ownerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ownerImageView.heightAnchor.constraint(equalTo: widthAnchor)
        ])
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: ownerImageView.bottomAnchor, constant: padding),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
}

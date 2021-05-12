//
//  MainScreenTableViewCell.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import UIKit
import SDWebImage

class RepositoryListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public static let id = "RepositoryListTableViewCell"
    public static let defaultHeight: CGFloat = 60
    private let imageSize: CGFloat = 46
    private let padding: CGFloat = 16
    
    // MARK: - Outlets
    
    private lazy var ownerImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemIcon: .user)?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .systemPink
        $0.clipsToBounds = true
        $0.layer.cornerRadius = imageSize / 2
        return $0
    }(UIImageView())
    
    private lazy var labelsStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
        $0.alignment = .leading
        return $0
    }(UIStackView())
    
    private lazy var ownerNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .systemGray2
        return $0
    }(UILabel())
    
    private lazy var repositoryNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .label
        return $0
    }(UILabel())
    
    private lazy var repositoryImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .systemPink
        return $0
    }(UIImageView())
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func set(with repository: RepositoryModel) {
        setLabels(for: repository)
        setLogoImage(for: repository)
        setAvatarImage(for: repository)
    }
    
    
    // MARK: - Setup
    
    private func setupUI() {
        setSubviews()
        setConstraints()
    }
    
    func setSubviews() {
        contentView.addSubviews(ownerImageView, labelsStackView, repositoryImageView)
        labelsStackView.addArrangedSubviews(repositoryNameLabel, ownerNameLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            ownerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ownerImageView.heightAnchor.constraint(equalToConstant: imageSize),
            ownerImageView.widthAnchor.constraint(equalToConstant: imageSize),
            ownerImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            repositoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            repositoryImageView.heightAnchor.constraint(equalToConstant: imageSize/2),
            repositoryImageView.widthAnchor.constraint(equalToConstant: imageSize/2),
            repositoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: padding),
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: repositoryImageView.leadingAnchor, constant: -padding)
        ])
    }
    
    // MARK: - Helpers
    
    private func setAvatarImage(for repository: RepositoryModel) {
        guard let url =  URL(string: repository.avatarLink) else { return }
        ownerImageView.sd_setImage(with: url) { [weak self] image, error, cache, urls in
            if error != nil {
                self?.ownerImageView.image = UIImage(systemIcon: .user)?.withRenderingMode(.alwaysTemplate)
            } else {
                self?.ownerImageView.image = image
            }
        }
    }
    
    private func setLogoImage(for repository: RepositoryModel) {
        repositoryImageView.image = UIImage(customImage: repository.isBitbucket ? .bitbucketLogo : .githubLogo)?.withRenderingMode(.alwaysTemplate)
    }
    
    private func setLabels(for repository: RepositoryModel) {
        repositoryNameLabel.text = repository.name
        ownerNameLabel.text = repository.ownerName
    }
    
}

//
//  ShortsCollectionViewCell.swift
//  Youtube
//
//  Created by Danil Chekantsev on 18/08/2025.
//

import UIKit

final class ShortsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ShortsCollectionViewCell"
    
    private var previewImage = UIImageView()
    private var settingsImage = UIImageView()
    private var titleLabel = UILabel()
    private var viewsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: VideoContent) {
        previewImage.load(from: URL(string: item.previewImage))
        titleLabel.text = item.title
        viewsLabel.text = "\(item.views)"
        
    }
    
    private func setupViews() {
        previewImage.image = UIImage(named: "preview")
        previewImage.contentMode = .scaleAspectFill
        previewImage.clipsToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 3
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        viewsLabel.font = UIFont.systemFont(ofSize: 12)
        viewsLabel.textColor = .white
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        settingsImage.image = UIImage(named: "options")
        
        contentView.addSubview(previewImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(settingsImage)
        setupConstraints()
    }
    
    private func setupCorners() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        previewImage.translatesAutoresizingMaskIntoConstraints = false
        settingsImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            previewImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            titleLabel.bottomAnchor.constraint(equalTo: viewsLabel.topAnchor, constant: -4),
            
            viewsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            settingsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            settingsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}

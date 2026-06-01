//
//  ShortsContentCell.swift
//  Youtube
//
//  Created by Danil Chekantsev on 23/08/2025.
//

import UIKit

final class ShortsContentCell: UICollectionViewCell {
    

    private let actionsStackView = UIStackView()
    
    private let likesIcon = UIImageView(image: UIImage(named: "likes"))
    private let dislikeIcon = UIImageView(image: UIImage(named: "dislike"))
    private let commentsIcon = UIImageView(image: UIImage(named: "comments"))
    private let shareIcon = UIImageView(image: UIImage(named: "share"))
    
    private let likesLabel = UILabel()
    private let dislikeLabel = UILabel()
    private let commentsLabel = UILabel()
    private let shareLabel = UILabel()
    
    private let subscribeImage = UIImageView()
    private let avatarImage = UIImageView()
    private let shortsImage = UIImageView()
    
    private let channelTitle = UILabel()
    private let shortsTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(shortsImage)
        
        NSLayoutConstraint.activate([
            shortsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            shortsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        setupUI()
        setupActionsUI()
        setupShortsInfoUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with video: VideoContent) {
        likesLabel.text = "\(video.likesCount)"
        commentsLabel.text = "\(video.commentsCount)"
        
        avatarImage.load(from: URL(string: video.avatar))
        shortsImage.load(from: URL(string: video.previewImage))
        
        channelTitle.text = video.channelTitle
        shortsTitle.text = video.title
    }
    
    private func setupUI() {
        contentView.addSubview(shortsImage)
        
        actionsStackView.axis = .vertical
        actionsStackView.alignment = .center
        actionsStackView.spacing = 8
        actionsStackView.distribution = .equalSpacing
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let actionsStack = [likesIcon, likesLabel, dislikeIcon, dislikeLabel, commentsIcon, commentsLabel, shareIcon, shareLabel]
        let shortsInfo = [channelTitle, subscribeImage, shortsTitle, avatarImage, actionsStackView]
        
        actionsStack.forEach {
            actionsStackView.addArrangedSubview($0)
        }
        
        shortsInfo.forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupActionsUI() {
        likesIcon.tintColor = .white
        likesIcon.contentMode = .scaleAspectFit
        likesIcon.translatesAutoresizingMaskIntoConstraints = false
        
        likesLabel.textColor = .white
        likesLabel.font = .systemFont(ofSize: 14, weight: .medium)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dislikeIcon.tintColor = .white
        dislikeIcon.contentMode = .scaleAspectFit
        dislikeIcon.translatesAutoresizingMaskIntoConstraints = false
        
        dislikeLabel.textColor = .white
        dislikeLabel.font = .systemFont(ofSize: 14, weight: .medium)
        dislikeLabel.text = "Dislike"
        dislikeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        commentsIcon.tintColor = .white
        commentsIcon.contentMode = .scaleAspectFit
        commentsIcon.translatesAutoresizingMaskIntoConstraints = false
        
        commentsLabel.textColor = .white
        commentsLabel.font = .systemFont(ofSize: 14, weight: .medium)
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        shareIcon.tintColor = .white
        shareIcon.contentMode = .scaleAspectFit
        shareIcon.translatesAutoresizingMaskIntoConstraints = false
        
        shareLabel.textColor = .white
        shareLabel.font = .systemFont(ofSize: 14, weight: .medium)
        shareLabel.text = "Share"
        shareLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupShortsInfoUI() {
        avatarImage.image = UIImage(named: "avatarVideo")
        avatarImage.contentMode = .scaleAspectFit
        avatarImage.layer.cornerRadius = 25
        avatarImage.layer.borderWidth = 1
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.clipsToBounds = true
        
        channelTitle.textColor = .white
        channelTitle.font = .systemFont(ofSize: 14, weight: .medium)
        channelTitle.numberOfLines = 1
        channelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        subscribeImage.image = UIImage(named: "subscribe")
        subscribeImage.layer.cornerRadius = 3
        subscribeImage.contentMode = .scaleAspectFit
        subscribeImage.translatesAutoresizingMaskIntoConstraints = false
        
        shortsTitle.font = .systemFont(ofSize: 16, weight: .bold)
        shortsTitle.textColor = .white
        shortsTitle.numberOfLines = 4
        shortsTitle.translatesAutoresizingMaskIntoConstraints = false
        
        shortsImage.contentMode = .scaleAspectFill
        shortsImage.clipsToBounds = true
        shortsImage.backgroundColor = .darkGray
        shortsImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -125),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            avatarImage.heightAnchor.constraint(equalToConstant: 50),
            avatarImage.widthAnchor.constraint(equalToConstant: 50),
            
            channelTitle.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 15),
            channelTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -143),
            
            subscribeImage.leadingAnchor.constraint(equalTo: channelTitle.trailingAnchor, constant: 15),
            subscribeImage.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor),
            subscribeImage.heightAnchor.constraint(equalToConstant: 50),
            subscribeImage.widthAnchor.constraint(equalToConstant: 100),
            
            shortsTitle.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            shortsTitle.bottomAnchor.constraint(equalTo: avatarImage.topAnchor, constant: -10),
            shortsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            
            actionsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 275),
            actionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }
}

extension ShortsContentCell {
    private func loadPreviewImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            shortsImage.backgroundColor = .darkGray
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.shortsImage.image = image
            }
        }.resume()
    }
    
    private func loadAvatarImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            avatarImage.image = UIImage(named: "avatarPreviewImage" )
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.avatarImage.image = image
            }
        }.resume()
    }
}


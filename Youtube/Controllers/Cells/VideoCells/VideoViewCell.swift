//
//  VideoCell.swift
//  Youtube
//
//  Created by Danil Chekantsev on 12/08/2025.
//

import UIKit

final class VideoViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "VideoCell"
    
    private let title = UILabel()
    private let views = UILabel()
    private let previewImage = UIImageView()
    private let options = UIImageView()
    private let avatar = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with video: VideoContent) {
        avatar.load(from: URL(string: video.avatar))
        previewImage.load(from: URL(string: video.previewImage))
        title.text = video.title
        views.text = video.views
    }
    
    private func setupViews() {
        avatar.image = UIImage(named: "avatarVideo")
        avatar.layer.cornerRadius = 20
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        previewImage.image = UIImage(named: "preview")
        previewImage.contentMode = .scaleAspectFill
        previewImage.clipsToBounds = true
        previewImage.translatesAutoresizingMaskIntoConstraints = false
        
        options.image = UIImage(named: "options")
        options.translatesAutoresizingMaskIntoConstraints = false 
        
        title.text = "Title"
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        views.text = "123"
        views.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        views.translatesAutoresizingMaskIntoConstraints = false
        
        [avatar, previewImage, options, title, views].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([            
            previewImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewImage.heightAnchor.constraint(equalToConstant: 200), // Фиксированная высота для превью
                        
            avatar.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: 12),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.heightAnchor.constraint(equalToConstant: 40),
                        
            title.topAnchor.constraint(equalTo: avatar.topAnchor),
            title.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 12),
            title.trailingAnchor.constraint(equalTo: options.leadingAnchor, constant: -12),
                        
            views.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            views.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            views.trailingAnchor.constraint(equalTo: title.trailingAnchor),
                        
            options.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            options.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            options.widthAnchor.constraint(equalToConstant: 3),
            options.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
}
extension UIImageView {

    func load(from url: URL?) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
 

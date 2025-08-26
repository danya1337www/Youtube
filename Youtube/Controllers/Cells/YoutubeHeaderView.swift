//
//  YoutubeHeaderView.swift
//  Youtube
//
//  Created by Danil Chekantsev on 12/08/2025.
//

import UIKit

final class YoutubeHeaderView: UIView {
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        createTopContainer()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func createTopContainer() -> UIView {
        let ytLogo = UIImageView(image: UIImage(named: "youtube"))
        ytLogo.contentMode = .scaleAspectFit
        ytLogo.clipsToBounds = true
        ytLogo.translatesAutoresizingMaskIntoConstraints = false
        
        let notifications = UIImageView(image: UIImage(named: "notification"))
        notifications.contentMode = .scaleAspectFit
        notifications.clipsToBounds = true
        notifications.translatesAutoresizingMaskIntoConstraints = false
        
        let screenMirroring = UIImageView(image: UIImage(named: "screenMirroring"))
        screenMirroring.contentMode = .scaleAspectFit
        screenMirroring.clipsToBounds = true
        screenMirroring.translatesAutoresizingMaskIntoConstraints = false
        
        let search = UIImageView(image: UIImage(named: "search"))
        search.contentMode = .scaleAspectFit
        search.clipsToBounds = true
        search.translatesAutoresizingMaskIntoConstraints = false
        
        let avatar = UIImageView(image: UIImage(named: "profile"))
        avatar.contentMode = .scaleAspectFit
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 12
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        [screenMirroring, notifications, search, avatar].forEach { stackView.addArrangedSubview($0) }
        
        let topContainer = UIView()
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topContainer)
        
        NSLayoutConstraint.activate([
                    topContainer.topAnchor.constraint(equalTo: topAnchor),
                    topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
                    topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
                    topContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
                    topContainer.heightAnchor.constraint(equalToConstant: 44)
                ])
        
        topContainer.addSubview(ytLogo)
        topContainer.addSubview(stackView)
        
        [screenMirroring, notifications, search, avatar].forEach { icon in
            icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
            icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
        
        ytLogo.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor).isActive = true
        ytLogo.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        ytLogo.widthAnchor.constraint(equalToConstant: 90).isActive = true
        ytLogo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        stackView.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: ytLogo.trailingAnchor, constant: 150).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        return topContainer
    }
}

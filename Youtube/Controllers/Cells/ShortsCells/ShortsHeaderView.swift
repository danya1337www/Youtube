//
//  ShortsHeaderViewCell.swift
//  Youtube
//
//  Created by Danil Chekantsev on 18/08/2025.
//

import UIKit

final class ShortsHeaderView: UIView {
    
    private let shortsLabel: UILabel = {
        let label = UILabel()
        label.text = "Shorts"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "shortsLogo")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(shortsLabel)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        shortsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            imageView.heightAnchor.constraint(equalToConstant: 35),
            
            shortsLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            shortsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}

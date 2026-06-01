//
//  ShortsViewCell.swift
//  Youtube
//
//  Created by Danil Chekantsev on 18/08/2025.
//

import UIKit

final class ShortsTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let reuseIdentifier = "ShortsTableViewCell"
    
    weak var delegate: ShortsTableViewCellDelegate?
    
    private let service = VideoContentService()
    private let headerCell = ShortsHeaderView()
    private let collectionView: UICollectionView
    private var shorts: [VideoContent] = []
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: [VideoContent]) {
            self.shorts = data
            collectionView.reloadData()
        }
    
    private func setupUI() {
        contentView.addSubview(headerCell)
        contentView.addSubview(collectionView)
        
        setupConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShortsCollectionViewCell.self, forCellWithReuseIdentifier: ShortsCollectionViewCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
                
    }
    
    private func setupConstraints() {
        headerCell.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            headerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerCell.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: headerCell.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 380)
        ])
    }
    
}

extension ShortsTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = shorts[indexPath.item]
        print("shorts selected: \(item)")
        
        delegate?.didSelectShorts(item, at: indexPath.item)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension ShortsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shorts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortsCollectionViewCell.reuseIdentifier, for: indexPath) as! ShortsCollectionViewCell
        
        let item = shorts[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
}

extension ShortsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}

protocol ShortsTableViewCellDelegate: AnyObject {
    func didSelectShorts(_ videoContent: VideoContent, at index: Int)
}

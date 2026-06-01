//
//  ShortsViewController.swift
//  Youtube
//
//  Created by Danil Chekantsev on 10/08/2025.
//

import UIKit

final class ShortsViewController: UIViewController {
    
    // MARK: - Properties
    private var items: [VideoContent] = []
    private var model: VideoContent?
    private var currentIndex: Int = 0
    private var isPushed: Bool = false
    
    private var service = VideoContentService()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ShortsContentCell.self, forCellWithReuseIdentifier: "ShortsContentCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isPushed && isMovingFromParent {
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.backgroundColor = .systemBackground
            navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setupNavigationBar()
                
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        if items.isEmpty {
            loadShortsData()
        }
        setupCollectionView()
        
    }
    
    //MARK: - Methods
    
    func configure(with data: [VideoContent], startingAt index: Int = 0, isPushed: Bool = false) {
        self.items = data
        self.currentIndex = index
        self.isPushed = isPushed
        if index < data.count {
            self.model = data[index]
        }
        collectionView.reloadData()
        
        DispatchQueue.main.async {
            if index > 0 && index < data.count {
                let indexPath = IndexPath(item: index, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        if isPushed {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.backgroundColor = UIColor.clear
        } else {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadShortsData() {
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let shorts = try await self.service.loadData()
                await MainActor.run {
                    self.items = shorts
                    if !shorts.isEmpty {
                        self.currentIndex = 0
                        self.model = shorts[0]
                        self.collectionView.reloadData()
                    }
                }
            } catch {
                print("Error loading shorts data: \(error)")
            }
        }
    }
}

// MARK: - CollectionView DataSource & Delegate
extension ShortsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortsContentCell", for: indexPath) as! ShortsContentCell
        let video = items[indexPath.item]
        cell.configure(with: video)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.y / scrollView.frame.height)
        if page < items.count {
            currentIndex = page
            model = items[currentIndex]
        }
    }
}

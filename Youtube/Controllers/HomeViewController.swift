//
//  HomeViewController.swift
//  Youtube
//
//  Created by Danil Chekantsev on 10/08/2025.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties

    private let service = VideoContentService()
    private let tableView = UITableView()
    private let filterScrollView = UIScrollView()
    private let filterStackView = UIStackView()
    
    private var videos: [VideoContent] = []
    private var shorts: [VideoContent] = []
    
    private let filters = ["All", "Mixes", "Music", "Graphic", "Gaming", "Sports", "News"]
    private var selectedFilterIndex = 0
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navBar = navigationController?.navigationBar else { return }
        
        navBar.setBackgroundImage(nil, for: .default)
        navBar.shadowImage = nil
        navBar.backgroundColor = .systemBackground
        navBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupNavigationBar()
        setupFilters()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.titleView = YoutubeHeaderView()
    }
    
    private func setupFilters() {
        filterScrollView.showsHorizontalScrollIndicator = false
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        filterStackView.axis = .horizontal
        filterStackView.spacing = 12
        filterStackView.alignment = .center
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, filter) in filters.enumerated() {
            let button = createFilterButton(title: filter, index: index)
            filterStackView.addArrangedSubview(button)
        }
        filterScrollView.addSubview(filterStackView)
        view.addSubview(filterScrollView)
        
        NSLayoutConstraint.activate([
            filterScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            filterScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterScrollView.heightAnchor.constraint(equalToConstant: 44),
            
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor)
        ])
    }
    
    private func createFilterButton(title: String, index: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        button.layer.cornerRadius = 16
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.borderWidth = 1
        button.tag = index
        button.addTarget(self, action: #selector(filterButtonTapped(_ :)), for: .touchUpInside)
        
        updateFilterButtonColors(button, isSelected: index == selectedFilterIndex)
        
        return button
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        selectedFilterIndex = sender.tag
        let selectedFilter = filters[selectedFilterIndex]
        print("\(selectedFilter) filter selected")
        
        updateAllButtonStyles()
    }
    
    private func updateFilterButtonColors(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = .systemGray6
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    private func updateAllButtonStyles() {
        for (index, view) in filterStackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                updateFilterButtonColors(button, isSelected: index == selectedFilterIndex)
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(VideoViewCell.self, forCellReuseIdentifier: VideoViewCell.reuseIdentifier)
        tableView.register(ShortsTableViewCell.self, forCellReuseIdentifier: ShortsTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 280
        tableView.separatorStyle = .none
        tableView.frame = view.bounds
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadData() {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                self.videos = try await self.service.loadData()
                self.shorts = try await self.service.loadData()
                print("loaded: \(videos.count)")
                
                await MainActor.run { self.tableView.reloadData() }
            } catch {
                assertionFailure("load data error: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShortsTableViewCell.reuseIdentifier,
                                                     for: indexPath) as! ShortsTableViewCell
            cell.delegate = self
            cell.configure(with: shorts)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoViewCell.reuseIdentifier,
                                                     for: indexPath) as! VideoViewCell
            
            let videoIndex = indexPath.row > 2 ? indexPath.row - 1 : indexPath.row
            let video = videos[videoIndex]
            
            cell.configure(with: video)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 360
        }
        return 280
    }
}

// MARK: - ShortsTableViewCellDelegate

extension HomeViewController: ShortsTableViewCellDelegate {
    func didSelectShorts(_ videoContent: VideoContent, at indexPath: Int) {
        let shortsVC = ShortsViewController()
        shortsVC.configure(with: shorts, startingAt: indexPath, isPushed: true)
                
        let backButtonImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)
        shortsVC.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
        navigationController?.pushViewController(shortsVC, animated: true)

    }
    
    @objc private func backTapped() {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
}


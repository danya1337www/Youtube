//
//  ViewController.swift
//  Youtube
//
//  Created by Danil Chekantsev on 10/08/2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: Properties
    
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let shortsVC = UINavigationController(rootViewController: ShortsViewController())

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItems()
        viewControllers = [homeVC, shortsVC]
    }
    
    // MARK: - Private Methods
    
    private func setupTabBarItems() {
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), tag: 0)
        shortsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "shorts"), tag: 1)
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}



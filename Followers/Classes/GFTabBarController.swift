//
//  GFTabBarController.swift
//  Followers
//
//  Created by Matt Brown on 12/21/20.
//

import UIKit

private enum GFAppTabs: String {
    case search = "Search"
    case favorites = "Favorites"
    
    private var tabBarItem: UITabBarItem {
        switch self {
        case .search:
            return UITabBarItem(tabBarSystemItem: .search, tag: 0)
        case .favorites:
            return UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        }
    }
    
    private var rootViewController: UIViewController {
        switch self {
        case .search:
            return SearchVC()
        case .favorites:
            return FavoritesListVC()
        }
    }
    
    var navigationController: UINavigationController {
        let rootViewController = self.rootViewController
        rootViewController.title = self.rawValue
        rootViewController.tabBarItem = self.tabBarItem
        return UINavigationController(rootViewController: rootViewController)
    }
}

final class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        UITabBar.appearance().tintColor = .systemGreen
        
        let searchNavCon = GFAppTabs.search.navigationController
        let favoritesNavCon = GFAppTabs.favorites.navigationController
        viewControllers = [searchNavCon, favoritesNavCon]
    }
}

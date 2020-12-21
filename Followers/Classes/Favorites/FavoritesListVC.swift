//
//  FavoritesListVC.swift
//  Followers
//
//  Created by Matt Brown on 11/29/20.
//

import UIKit

final class FavoritesListVC: UIViewController {
    private enum ViewMetrics {
        static let backgroundColor = UIColor.systemBlue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                favorites.forEach { print($0.username) }
                
            case .failure(_):
                break
            }
        }
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
    }
}

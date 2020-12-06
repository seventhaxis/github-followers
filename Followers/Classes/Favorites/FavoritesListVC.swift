//
//  FavoritesListVC.swift
//  Followers
//
//  Created by Matt Brown on 11/29/20.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor = UIColor.systemBlue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
    }
}

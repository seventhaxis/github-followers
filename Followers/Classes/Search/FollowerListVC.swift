//
//  FollowerListVC.swift
//  Followers
//
//  Created by Matt Brown on 12/5/20.
//

import UIKit

final class FollowerListVC: UIViewController {
    
    private enum ViewMetrics {
        static let bgColor = UIColor.systemBackground
    }
    
    private let targetUser: String
    
    init(user: String) {
        self.targetUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = targetUser
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = ViewMetrics.bgColor
    }
}

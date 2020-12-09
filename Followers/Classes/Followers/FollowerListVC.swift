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
        setupView()
        NetworkManager.shared.getFollowers(for: targetUser, page: 1) { [weak self] result in
            switch result {
            case .success(let followers):
                print("Followers: " + followers.count.description)
                followers.forEach { print($0.username) }
                
            case .failure(let error):
                self?.presentGFAlert(title: "Uh Oh", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupView() {
        navigationItem.title = targetUser
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = ViewMetrics.bgColor
    }
}

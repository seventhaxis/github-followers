//
//  UserInfoVC.swift
//  Followers
//
//  Created by Matt Brown on 12/16/20.
//

import UIKit

final class UserInfoVC: UIViewController {
    private enum ViewMetrics {
        static let backgroundColor = UIColor.systemGreen
    }
    
    private let targetUser: Follower
    
    init(for follower: Follower) {
        self.targetUser = follower
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getUserInfo(for: targetUser.username) { [weak self] (result) in
            switch result {
            case .success(let user):
                print(user)
                
            case .failure(let error):
                self?.presentGFAlert(title: "Uh Oh", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
}

extension UserInfoVC {
    @objc func doneButtonTapped() {
        dismiss(animated: true)
    }
}

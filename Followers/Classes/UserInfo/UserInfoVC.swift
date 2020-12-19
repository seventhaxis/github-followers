//
//  UserInfoVC.swift
//  Followers
//
//  Created by Matt Brown on 12/16/20.
//

import UIKit

final class UserInfoVC: UIViewController {
    private enum ViewMetrics {
        static let backgroundColor = UIColor.systemBackground
        static let directionalMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        static let headerHeight: CGFloat = 180.0
    }
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let targetUsername: String
    
    init(for follower: Follower) {
        self.targetUsername = follower.username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getUserInfo(for: targetUsername) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childViewController: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlert(title: "Uh Oh", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
//        view.directionalLayoutMargins = ViewMetrics.directionalMargins
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        
        [headerView].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: ViewMetrics.headerHeight),
        ])
    }
}

extension UserInfoVC {
    @objc func doneButtonTapped() {
        dismiss(animated: true)
    }
    
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}

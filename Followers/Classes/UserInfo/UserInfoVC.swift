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
        
        static let headerViewHeight: CGFloat = 180.0
        static let interItemPadding: CGFloat = 20.0
        static let detailBoxHeight: CGFloat = 140.0
    }
    
    private let headerView = UIView.containerView()
    private let userDetailBox1 = UIView.containerView(bgColor: .systemPink)
    private let userDetailBox2 = UIView.containerView(bgColor: .systemGreen)
    
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
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        
        [headerView, userDetailBox1, userDetailBox2].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            headerView.heightAnchor.constraint(lessThanOrEqualToConstant: ViewMetrics.headerViewHeight),
            
            userDetailBox1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: ViewMetrics.interItemPadding),
            userDetailBox1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            userDetailBox1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            userDetailBox1.heightAnchor.constraint(equalToConstant: ViewMetrics.detailBoxHeight),
            
            userDetailBox2.topAnchor.constraint(equalTo: userDetailBox1.bottomAnchor, constant: ViewMetrics.interItemPadding),
            userDetailBox2.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            userDetailBox2.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            userDetailBox2.heightAnchor.constraint(equalToConstant: ViewMetrics.detailBoxHeight),
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

private extension UIView {
    static func containerView(bgColor: UIColor = .clear) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = bgColor
        return view
    }
}

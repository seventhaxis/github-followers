//
//  UserInfoVC.swift
//  Followers
//
//  Created by Matt Brown on 12/16/20.
//

import UIKit

final class UserInfoVC: GFDataLoadingVC {
    private enum ViewMetrics {
        static let backgroundColor = UIColor.systemBackground
        
        static let headerViewHeight: CGFloat = 180.0
        static let interItemPadding: CGFloat = 20.0
        static let detailBoxHeight: CGFloat = 140.0
    }
    
    private let targetUsername: String
    weak var followableDelegate: FollowersFetchable?
    
    private let headerView = UIView.containerView()
    private let userDetailBox1 = UIView.containerView()
    private let userDetailBox2 = UIView.containerView()
    private let dateLabel = GFBodyLabel(textAlignment: .center)
    
    private let contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
                DispatchQueue.main.async { self.configureProfileCards(for: user) }
                
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
        
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentContainer)
        contentContainer.addSubviews(headerView, userDetailBox1, userDetailBox2, dateLabel)
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            
            contentContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentContainer.heightAnchor.constraint(equalToConstant: 600),
            
            headerView.topAnchor.constraint(equalTo: contentContainer.layoutMarginsGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentContainer.layoutMarginsGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentContainer.layoutMarginsGuide.trailingAnchor),
            headerView.heightAnchor.constraint(lessThanOrEqualToConstant: ViewMetrics.headerViewHeight),
            
            userDetailBox1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: ViewMetrics.interItemPadding),
            userDetailBox1.leadingAnchor.constraint(equalTo: contentContainer.layoutMarginsGuide.leadingAnchor),
            userDetailBox1.trailingAnchor.constraint(equalTo: contentContainer.layoutMarginsGuide.trailingAnchor),
            userDetailBox1.heightAnchor.constraint(equalToConstant: ViewMetrics.detailBoxHeight),
            
            userDetailBox2.topAnchor.constraint(equalTo: userDetailBox1.bottomAnchor, constant: ViewMetrics.interItemPadding),
            userDetailBox2.leadingAnchor.constraint(equalTo: contentContainer.layoutMarginsGuide.leadingAnchor),
            userDetailBox2.trailingAnchor.constraint(equalTo: contentContainer.layoutMarginsGuide.trailingAnchor),
            userDetailBox2.heightAnchor.constraint(equalToConstant: ViewMetrics.detailBoxHeight),
            
            dateLabel.centerXAnchor.constraint(equalTo: contentContainer.layoutMarginsGuide.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: userDetailBox2.bottomAnchor, constant: ViewMetrics.interItemPadding),
        ])
    }
    
    private func configureProfileCards(for user: User) {
        add(childViewController: UserInfoHeaderVC(user: user), to: headerView)
        
        let projectCard = UserInfoItemCardVC(.projects, for: user)
        projectCard.delegate = self
        add(childViewController: projectCard, to: userDetailBox1)
        
        let socialCard = UserInfoItemCardVC(.social, for: user)
        socialCard.delegate = self
        add(childViewController: socialCard, to: userDetailBox2)
        
        let profileCreationDate = user.createdAt.convertToString(format: "MMM yyyy")
        dateLabel.text = "Member since \(profileCreationDate)"
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

extension UserInfoVC: UserInfoItemCardDelegate {
    func didTapViewFollowersButton(for user: User) {
        dismiss(animated: true)
        followableDelegate?.didRequestFollowers(for: user.username)
    }
    
    func didTapViewProfileButton(for user: User) {
        guard let url = URL(string: user.profileURL) else {
            presentGFAlert(title: "Uh Oh", message: "Invalid profile URL for selected user: \(user.username)", buttonTitle: "OK")
            return
        }
        presentSafariViewController(with: url)
    }
}

private extension UIView {
    static func containerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

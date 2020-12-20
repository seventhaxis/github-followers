//
//  UserInfoItemCardVC.swift
//  Followers
//
//  Created by Matt Brown on 12/19/20.
//

import UIKit

enum GFProfileCard {
    case projects
    case social
    
    var card1: GFProfileItem {
        switch self {
        case .projects:
            return .publicRepos
        case .social:
            return .following
        }
    }
    
    var card2: GFProfileItem {
        switch self {
        case .projects:
            return .publicGists
        case .social:
            return .followers
        }
    }
    
    var actionButtonTitle: String {
        switch self {
        case .projects:
            return "View Profile"
        case .social:
            return "View Followers"
        }
    }
    
    var actionButtonBackgroundColor: UIColor {
        switch self {
        case .projects:
            return .systemPurple
        case .social:
            return .systemGreen
        }
    }
}

protocol UserInfoItemCardDelegate: AnyObject {
    func didTapViewFollowersButton(for user: User)
    func didTapViewProfileButton(for user: User)
}

final class UserInfoItemCardVC: UIViewController {
    private enum ViewMetrics {
        static let backgroundColor = UIColor.secondarySystemBackground
        static let cornerRadius: CGFloat = 18.0
        static let directionalMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        static let detailStackHeight: CGFloat = 50.0
        
        static let projectButtonBackgroundColor = UIColor.systemPurple
        static let socialButtonBackgroundColor = UIColor.systemGreen
    }
    
    weak var delegate: UserInfoItemCardDelegate?
    
    private let cardType: GFProfileCard
    private let targetUser: User
    
    private lazy var profileItem1: GFProfileItemView = {
        let itemCount = (cardType == .projects) ? targetUser.publicRepos : targetUser.following
        let view = GFProfileItemView(type: cardType.card1, withCount: itemCount)
        return view
    }()
    
    private lazy var profileItem2: GFProfileItemView = {
        let itemCount = (cardType == .projects) ? targetUser.publicGists : targetUser.followers
        let view = GFProfileItemView(type: cardType.card2, withCount: itemCount)
        return view
    }()
    
    private lazy var detailStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileItem1, profileItem2])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var actionButton: GFButton = {
        let button = GFButton(bgColor: cardType.actionButtonBackgroundColor, title: cardType.actionButtonTitle)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(_ type: GFProfileCard, for user: User) {
        self.cardType = type
        self.targetUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        view.directionalLayoutMargins = ViewMetrics.directionalMargins
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        
        [detailStackView, actionButton].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            detailStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            detailStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            detailStackView.heightAnchor.constraint(equalToConstant: ViewMetrics.detailStackHeight),
            
            actionButton.topAnchor.constraint(equalToSystemSpacingBelow: detailStackView.bottomAnchor, multiplier: 1.0),
            actionButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
}

private extension UserInfoItemCardVC {
    @objc func actionButtonTapped() {
        switch cardType {
        case .projects:
            delegate?.didTapViewProfileButton(for: targetUser)
        case .social:
            delegate?.didTapViewFollowersButton(for: targetUser)
        }
    }
}

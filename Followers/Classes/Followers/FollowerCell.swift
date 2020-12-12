//
//  FollowerCell.swift
//  Followers
//
//  Created by Matt Brown on 12/10/20.
//

import UIKit

final class FollowerCell: UICollectionViewCell, ReusableIdentifier {
    private enum ViewMetrics {
        static let usernameLabelFontSize: CGFloat = 16.0
        static let directionalMargins = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
    }
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: ViewMetrics.usernameLabelFontSize)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.directionalLayoutMargins = ViewMetrics.directionalMargins
        
        [avatarImageView, usernameLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: avatarImageView.bottomAnchor, multiplier: 1.0),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    func configure(for follower: Follower) {
        usernameLabel.text = follower.username
        avatarImageView.downloadAvatar(from: follower.avatarURL)
    }
}

//
//  FavoriteCell.swift
//  Followers
//
//  Created by Matt Brown on 12/20/20.
//

import UIKit

final class FavoriteCell: UITableViewCell, ReusableIdentifier {
    private enum ViewMetrics {
        static let directionalMargins = NSDirectionalEdgeInsets(top: 12.0, leading: 12.0, bottom: 12.0, trailing: 12.0)
        static let interItemSpacing: CGFloat = 26.0
        static let avatarWidth: CGFloat = 60.0
        static let usernameLabelFontSize: CGFloat = 26.0
    }
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: ViewMetrics.usernameLabelFontSize)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        accessoryType = .disclosureIndicator
        contentView.directionalLayoutMargins = ViewMetrics.directionalMargins
        
        contentView.addSubviews(avatarImageView, usernameLabel)
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: ViewMetrics.avatarWidth),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: ViewMetrics.interItemSpacing),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func configure(for favorite: Follower) {
        usernameLabel.text = favorite.username
        avatarImageView.downloadImage(fromURLString: favorite.avatarURL)
    }
}

//
//  UserInfoHeaderVC.swift
//  Followers
//
//  Created by Matt Brown on 12/18/20.
//

import UIKit

final class UserInfoHeaderVC: UIViewController {
    private enum ViewMetrics {
        static let usernameFontSize: CGFloat = 34.0
        static let nameFontSize: CGFloat = 18.0
        static let locationFontSize: CGFloat = 18.0
        
        static let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        static let interItemPadding: CGFloat = 12.0
        static let avatarWidth: CGFloat = 90.0
        static let locationIconWidth: CGFloat = 20.0
    }
    
    private var targetUser: User
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    
    private lazy var usernameLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .left, fontSize: ViewMetrics.usernameFontSize)
        label.text = targetUser.username
        return label
    }()
    private lazy var nameLabel: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: ViewMetrics.nameFontSize)
        label.text = targetUser.name ?? ""
        return label
    }()
    
    private lazy var locationImageView: UIImageView = {
        let iv = UIImageView(image: GFResource.Image.SFSymbol.mapPinAndEllipse)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .secondaryLabel
        return iv
    }()
    
    private lazy var locationLabel: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: ViewMetrics.locationFontSize)
        label.text = targetUser.location ?? ""
        return label
    }()
    
    private lazy var bioLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .left)
        label.text = targetUser.bio ?? ""
        label.numberOfLines = 3
        return label
    }()
    
    init(user: User) {
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
        view.layoutMargins = ViewMetrics.edgeInsets
        
        [avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: ViewMetrics.avatarWidth),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: ViewMetrics.interItemPadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8.0),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: ViewMetrics.interItemPadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: ViewMetrics.interItemPadding),
            locationImageView.widthAnchor.constraint(equalToConstant: ViewMetrics.locationIconWidth),
            locationImageView.heightAnchor.constraint(equalTo: locationImageView.widthAnchor),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5.0),
            locationLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: ViewMetrics.interItemPadding),
            bioLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
        
        NetworkManager.shared.downloadImage(from: targetUser.avatarURL) { (image) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.avatarImageView.image = image
            }
        }
    }
}

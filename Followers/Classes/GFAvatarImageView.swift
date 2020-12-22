//
//  GFAvatarImageView.swift
//  Followers
//
//  Created by Matt Brown on 12/10/20.
//

import UIKit

final class GFAvatarImageView: UIImageView {
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 10.0
    }
    
    let placeholderImage = GFResource.Image.avatarPlaceholder
    let avatarCache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        image = placeholderImage
        layer.cornerRadius = ViewMetrics.cornerRadius
    }
}

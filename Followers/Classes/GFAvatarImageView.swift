//
//  GFAvatarImageView.swift
//  Followers
//
//  Created by Matt Brown on 12/10/20.
//

import UIKit

class GFAvatarImageView: UIImageView {
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 10.0
    }

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
        
        image = UIImage(named: "avatar-placeholder")!
        layer.cornerRadius = ViewMetrics.cornerRadius
    }
}

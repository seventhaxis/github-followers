//
//  GFEmptyStateView.swift
//  Followers
//
//  Created by Matt Brown on 12/15/20.
//

import UIKit

final class GFEmptyStateView: UIView {
    private enum ViewMetrics {
        static let directionalLayoutMargins = NSDirectionalEdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40)
        
        static let logoImageWidthMultiplier: CGFloat = 1.3
        static let logoImageHorizontalOffset: CGFloat = 170.0
        static let logoImageVerticalOffset: CGFloat = 40.0
        
        static let messageLabelFontSize: CGFloat = 28.0
        static let messageLabelTextColor = UIColor.secondaryLabel
        static let messageLabelOffset: CGFloat = -150.0
    }
    
    private let messageLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center, fontSize: ViewMetrics.messageLabelFontSize)
        label.numberOfLines = 3
        label.textColor = ViewMetrics.messageLabelTextColor
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let logo = UIImage(named: "empty-state-logo")
        let view = UIImageView(image: logo)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        directionalLayoutMargins = ViewMetrics.directionalLayoutMargins
        
        [logoImageView, messageLabel].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: ViewMetrics.logoImageWidthMultiplier),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: ViewMetrics.logoImageHorizontalOffset),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ViewMetrics.logoImageVerticalOffset),
            
            messageLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: ViewMetrics.messageLabelOffset),
        ])
    }

}

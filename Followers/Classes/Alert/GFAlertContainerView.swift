//
//  GFAlertContainerView.swift
//  Followers
//
//  Created by Matt Brown on 12/21/20.
//

import UIKit

final class GFAlertContainerView: UIView {
    private enum ViewMetrics {
        static let containerLayoutMargins = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        static let containerBackgroundColor = UIColor.systemBackground
        static let containerCornerRadius: CGFloat = 16.0
        static let containerBorderWidth: CGFloat = 2.0
        static let containerBorderColor = UIColor.white.cgColor
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
        layoutMargins = ViewMetrics.containerLayoutMargins
        backgroundColor = ViewMetrics.containerBackgroundColor
        
        layer.cornerRadius = ViewMetrics.containerCornerRadius
        layer.borderWidth = ViewMetrics.containerBorderWidth
        layer.borderColor = ViewMetrics.containerBorderColor
    }
}


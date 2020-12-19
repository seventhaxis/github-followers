//
//  GFSecondaryTitleLabel.swift
//  Followers
//
//  Created by Matt Brown on 12/18/20.
//

import UIKit

final class GFSecondaryTitleLabel: UILabel {
    private enum ViewMetrics {
        static let textColor = UIColor.secondaryLabel
        static let minScaleFactor: CGFloat = 0.9
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = ViewMetrics.textColor
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = ViewMetrics.minScaleFactor
        lineBreakMode = .byTruncatingTail
    }
}

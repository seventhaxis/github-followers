//
//  GFTitleLabel.swift
//  Followers
//
//  Created by Matt Brown on 12/6/20.
//

import UIKit

final class GFTitleLabel: UILabel {
    private enum ViewMetrics {
        static let textColor = UIColor.label
        static let minScaleFactor: CGFloat = 0.9
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = .systemFont(ofSize: fontSize, weight: .bold)
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

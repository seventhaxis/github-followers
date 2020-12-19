//
//  GFBodyLabel.swift
//  Followers
//
//  Created by Matt Brown on 12/7/20.
//

import UIKit

final class GFBodyLabel: UILabel {
    private enum ViewMetrics {
        static let textColor = UIColor.secondaryLabel
        static let minScaleFactor: CGFloat = 0.75
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        font = .preferredFont(forTextStyle: .body)
        textColor = ViewMetrics.textColor
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = ViewMetrics.minScaleFactor
        lineBreakMode = .byWordWrapping
    }
}

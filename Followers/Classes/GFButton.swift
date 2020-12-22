//
//  GFButton.swift
//  Followers
//
//  Created by Matt Brown on 12/5/20.
//

import UIKit

final class GFButton: UIButton {
    private enum ViewMetrics {
        static let textColor = UIColor.white
        static let preferredFont = UIFont.preferredFont(forTextStyle: .headline)
        static let contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        static let cornerRadius: CGFloat = 10.0
    }

    init(bgColor: UIColor, title: String) {
        super.init(frame: .zero)
        setupView()
        
        backgroundColor = bgColor
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitleColor(ViewMetrics.textColor, for: .normal)
        titleLabel?.font = ViewMetrics.preferredFont
        
        contentEdgeInsets = ViewMetrics.contentEdgeInsets
        layer.cornerRadius = ViewMetrics.cornerRadius
    }
}

//
//  GFButton.swift
//  Followers
//
//  Created by Matt Brown on 12/5/20.
//

import UIKit

class GFButton: UIButton {
    
    private enum ViewMetrics {
        static let textColor = UIColor.white
        static let preferredFont = UIFont.preferredFont(forTextStyle: .headline)
        
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
        
        layer.cornerRadius = ViewMetrics.cornerRadius
    }
}

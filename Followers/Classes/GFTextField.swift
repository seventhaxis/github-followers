//
//  GFTextField.swift
//  Followers
//
//  Created by Matt Brown on 12/5/20.
//

import UIKit

enum GFTextFieldType {
    case userSearch
    
    var placeholderText: String {
        switch self {
        case .userSearch:
            return "Enter Username"
        }
    }
    
    var returnKeyType: UIReturnKeyType {
        switch self {
        default:
            return .go
        }
    }
}

final class GFTextField: UITextField {
    
    private enum ViewMetrics {
        static let backgroundColor = UIColor.tertiarySystemBackground
        
        static let textColor = UIColor.label
        static let tintColor = UIColor.label
        static let textAlignment = NSTextAlignment.center
        static let font = UIFont.preferredFont(forTextStyle: .title2)
        static let minimumFontSize: CGFloat = 12.0
        
        static let cornerRadius: CGFloat = 10.0
        static let borderWidth: CGFloat = 2.0
        static let borderColor = UIColor.systemGray4.cgColor
    }
    
    private let type: GFTextFieldType
    
    init(type: GFTextFieldType) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        placeholder = type.placeholderText
        autocorrectionType = .no
        autocapitalizationType = .none
        returnKeyType = type.returnKeyType
        
        backgroundColor = ViewMetrics.backgroundColor
        
        textColor = ViewMetrics.textColor
        tintColor = ViewMetrics.tintColor
        textAlignment = ViewMetrics.textAlignment
        font = ViewMetrics.font
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize = ViewMetrics.minimumFontSize
        
        layer.cornerRadius = ViewMetrics.cornerRadius
        layer.borderWidth = ViewMetrics.borderWidth
        layer.borderColor = ViewMetrics.borderColor
    }
}

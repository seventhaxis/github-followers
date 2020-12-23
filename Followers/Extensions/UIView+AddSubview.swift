//
//  UIView+AddSubview.swift
//  Followers
//
//  Created by Matt Brown on 12/22/20.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

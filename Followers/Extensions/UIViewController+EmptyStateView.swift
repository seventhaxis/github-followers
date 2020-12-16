//
//  UIViewController+EmptyStateView.swift
//  Followers
//
//  Created by Matt Brown on 12/16/20.
//

import UIKit

extension UIViewController {
    func showEmptyStateView(message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

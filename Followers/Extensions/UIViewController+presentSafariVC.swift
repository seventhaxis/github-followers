//
//  UIViewController+presentSafariVC.swift
//  Followers
//
//  Created by Matt Brown on 12/20/20.
//

import Foundation
import SafariServices

extension UIViewController {
    func presentSafariViewController(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}

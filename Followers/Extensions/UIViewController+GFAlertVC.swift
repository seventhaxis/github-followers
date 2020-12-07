//
//  UIViewController+GFAlertVC.swift
//  Followers
//
//  Created by Matt Brown on 12/7/20.
//

import UIKit

extension UIViewController {
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self?.present(alert, animated: true)
        }
    }
}

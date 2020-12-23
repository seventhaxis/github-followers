//
//  UITableView+RemoveExtraCells.swift
//  Followers
//
//  Created by Matt Brown on 12/23/20.
//

import UIKit

extension UITableView {
    func removeExtraCells() {
        tableFooterView = UIView(frame: .zero)
    }
}

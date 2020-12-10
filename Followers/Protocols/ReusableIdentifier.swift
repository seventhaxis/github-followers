//
//  ReusableIdentifier.swift
//  Followers
//
//  Created by Matt Brown on 12/10/20.
//

import Foundation

protocol ReusableIdentifier: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableIdentifier {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

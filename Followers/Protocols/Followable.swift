//
//  Followable.swift
//  Followers
//
//  Created by Matt Brown on 12/20/20.
//

import Foundation

protocol Followable: AnyObject {
    func didRequestFollowers(for username: String)
}

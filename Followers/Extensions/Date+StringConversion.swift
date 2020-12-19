//
//  Date+StringConversion.swift
//  Followers
//
//  Created by Matt Brown on 12/19/20.
//

import Foundation

extension Date {
    func convertToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

//
//  String+DateConversion.swift
//  Followers
//
//  Created by Matt Brown on 12/19/20.
//

import Foundation

extension String {
    var convertedToDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.date(from: self)
        return formatter.date(from: self)
    }
}

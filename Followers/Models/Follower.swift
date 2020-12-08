//
//  Follower.swift
//  Followers
//
//  Created by Matt Brown on 12/7/20.
//

import Foundation

struct Follower {
    var username: String
    var avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
    }
}

extension Follower: Codable {
    init(from decoder: Decoder) throws {
        let rawValues = try decoder.container(keyedBy: CodingKeys.self)
        username = try rawValues.decode(String.self, forKey: .username)
        avatarURL = try rawValues.decode(String.self, forKey: .avatarURL)
    }
}

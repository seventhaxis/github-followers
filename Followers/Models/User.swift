//
//  User.swift
//  Followers
//
//  Created by Matt Brown on 12/7/20.
//

import Foundation

struct User {
    var username: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var profileUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_url"
        case name
        case location
        case bio
        case publicRepos
        case publicGists
        case profileUrl = "html_url"
        case following
        case followers
        case createdAt
    }
}

extension User: Codable {
    init(from decoder: Decoder) throws {
        let rawValues = try decoder.container(keyedBy: CodingKeys.self)
        username = try rawValues.decode(String.self, forKey: .username)
        avatarUrl = try rawValues.decode(String.self, forKey: .avatarUrl)
        name = try rawValues.decode(String.self, forKey: .name)
        location = try rawValues.decode(String.self, forKey: .location)
        bio = try rawValues.decode(String.self, forKey: .bio)
        publicRepos = try rawValues.decode(Int.self, forKey: .publicRepos)
        publicGists = try rawValues.decode(Int.self, forKey: .publicGists)
        profileUrl = try rawValues.decode(String.self, forKey: .profileUrl)
        following = try rawValues.decode(Int.self, forKey: .following)
        followers = try rawValues.decode(Int.self, forKey: .followers)
        createdAt = try rawValues.decode(String.self, forKey: .createdAt)
    }
}

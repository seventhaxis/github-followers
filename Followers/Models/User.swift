//
//  User.swift
//  Followers
//
//  Created by Matt Brown on 12/7/20.
//

import Foundation

struct User {
    let username: String
    let avatarURL: String
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let profileURL: String
    let following: Int
    let followers: Int
    let createdAt: Date
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
        case name
        case location
        case bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case profileURL = "html_url"
        case following
        case followers
        case createdAt = "created_at"
    }
    
    init(from decoder: Decoder) throws {
        let rawValues = try decoder.container(keyedBy: CodingKeys.self)
        username = try rawValues.decode(String.self, forKey: .username)
        avatarURL = try rawValues.decode(String.self, forKey: .avatarURL)
        name = try rawValues.decode(String?.self, forKey: .name)
        location = try rawValues.decode(String?.self, forKey: .location)
        bio = try rawValues.decode(String?.self, forKey: .bio)
        publicRepos = try rawValues.decode(Int.self, forKey: .publicRepos)
        publicGists = try rawValues.decode(Int.self, forKey: .publicGists)
        profileURL = try rawValues.decode(String.self, forKey: .profileURL)
        following = try rawValues.decode(Int.self, forKey: .following)
        followers = try rawValues.decode(Int.self, forKey: .followers)
        createdAt = try rawValues.decode(Date.self, forKey: .createdAt)
    }
}

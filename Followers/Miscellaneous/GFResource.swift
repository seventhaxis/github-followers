//
//  GFResource.swift
//  Followers
//
//  Created by Matt Brown on 12/21/20.
//

import UIKit

enum GFResource {
    enum Image {
        static let avatarPlaceholder = UIImage(named: "avatar-placeholder")
        static let emptyStateLogo = UIImage(named: "empty-state-logo")
        static let ghLogo = UIImage(named: "gh-logo")
        
        enum SFSymbol {
            static let folder = UIImage(systemName: "folder")
            static let heart = UIImage(systemName: "heart")
            static let mapPinAndEllipse = UIImage(systemName: "mappin.and.ellipse")
            static let person2 = UIImage(systemName: "person.2")
            static let star = UIImage(systemName: "star")
            static let textAlignLeft = UIImage(systemName: "text.alignleft")
        }
    }
}

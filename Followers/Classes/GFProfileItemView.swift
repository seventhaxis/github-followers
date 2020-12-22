//
//  GFProfileItemView.swift
//  Followers
//
//  Created by Matt Brown on 12/18/20.
//

import UIKit

enum GFProfileItem: String {
    case followers = "Followers"
    case following = "Following"
    case publicGists = "Public Gists"
    case publicRepos = "Public Repos"
    
    var title: String {
        return self.rawValue
    }
    
    var iconImage: UIImage? {
        switch self {
        case .followers:
            return GFResource.Image.SFSymbol.person2
        case .following:
            return GFResource.Image.SFSymbol.heart
        case .publicGists:
            return GFResource.Image.SFSymbol.textAlignLeft
        case .publicRepos:
            return GFResource.Image.SFSymbol.folder
        }
    }
}

final class GFProfileItemView: UIView {
    private enum ViewMetrics {
        static let symbolImageTintColor = UIColor.label
        static let symbolImageWidth: CGFloat = 20.0
        
        static let interItemSpacing: CGFloat = 12.0
    }
    
    private let type: GFProfileItem
    
    private lazy var symbolImageView: UIImageView = {
        let iv = UIImageView(image: type.iconImage)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = ViewMetrics.symbolImageTintColor
        return iv
    }()
    
    private lazy var titleLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .left, fontSize: 14.0)
        label.text = type.title
        return label
    }()
    
    private lazy var itemCountLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center, fontSize: 14.0)
        return label
    }()
    
    init(type: GFProfileItem, withCount count: Int) {
        self.type = type
        super.init(frame: .zero)
        itemCountLabel.text = count.description
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        [symbolImageView, titleLabel, itemCountLabel].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: ViewMetrics.symbolImageWidth),
            symbolImageView.heightAnchor.constraint(equalTo: symbolImageView.widthAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: ViewMetrics.interItemSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            itemCountLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: ViewMetrics.interItemSpacing),
            itemCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

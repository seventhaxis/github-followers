//
//  GFAvatarImageView.swift
//  Followers
//
//  Created by Matt Brown on 12/10/20.
//

import UIKit

class GFAvatarImageView: UIImageView {
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 10.0
    }
    
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    let avatarCache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        image = placeholderImage
        layer.cornerRadius = ViewMetrics.cornerRadius
    }
}

extension GFAvatarImageView {
    func downloadAvatar(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let userAvatar = avatarCache.object(forKey: cacheKey) {
            self.image = userAvatar
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data, let userAvatar = UIImage(data: data) else { return }
            
            self.avatarCache.setObject(userAvatar, forKey: cacheKey)
            DispatchQueue.main.async { self.image = userAvatar }
        }
        task.resume()
    }
}

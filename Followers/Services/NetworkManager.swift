//
//  NetworkManager.swift
//  Followers
//
//  Created by Matt Brown on 12/7/20.
//

import UIKit

final class NetworkManager {
    private init() { }
    static let shared = NetworkManager()
    
    let cache = NSCache<NSString, UIImage>()
    private let baseURL = "https://api.github.com"
    
    let followersPerPage = 99
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(followersPerPage)&page=\(page)"
        guard let targetURL = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: targetURL) { (data, response, error) in
            if let _ = error {
                completion(.failure(.incompleteRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidServerResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidDataReceived))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            }
            catch {
                completion(.failure(.unableToDecodeData))
            }
        }
        task.resume()
    }
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)"
        guard let targetURL = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: targetURL) { (data, response, error) in
            if let _ = error {
                completion(.failure(.incompleteRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidServerResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidDataReceived))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            }
            catch {
                completion(.failure(.unableToDecodeData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200 ,
                  let data = data, let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}

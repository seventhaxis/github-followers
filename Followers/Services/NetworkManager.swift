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
}

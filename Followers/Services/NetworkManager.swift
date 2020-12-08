//
//  NetworkManager.swift
//  Followers
//
//  Created by Matt Brown on 12/7/20.
//

import Foundation

final class NetworkManager {
    
    private init() { }
    static let shared = NetworkManager()
    
    let baseURL = "https://api.github.com"
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        guard let targetURL = URL(string: endpoint) else {
            completion(nil, "Invalid Username Request")
            return
        }
        
        let task = URLSession.shared.dataTask(with: targetURL) { data, response, error in
            if let _ = error {
                completion(nil, "Unable to complete request. Please check network connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completion(nil, "The data received from the server was invalid. Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            }
            catch {
                completion(nil, "Unable to decode data received from server. Please try again.")
            }
        }
        
        task.resume()
    }
}

//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 09/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared       = NetworkManager()
    private let baseUrl     = "https://api.github.com/users/"
    let cache               = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, perPage: Int, completed: @escaping ([Follower]?, GHError?) -> Void) {
        print("inside getfollowers")
        let endpoint = baseUrl + "\(username)/followers?per_page=\(perPage)&page=\(page)"
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUsername)
            return
        }
        print("url is good")
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            print("inside session task")
            if let _ = error {
                print("ERROR")
                completed(nil, .unableToComplete)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                
                return
            }
            
            print(response.statusCode)
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder                 = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers               = try decoder.decode([Follower].self, from: data)
                print("inside network manager \(followers.count)")
                DispatchQueue.main.async {
                    completed(followers, nil)
                }
//                completed(followers, nil)
                
            } catch {
                print("catch")
                completed(nil, .invalidData)
            }
        }
            task.resume()
//        print(task)
        
        print("task completed")
    }
    
    
    func getUserInfo(for username: String, completed: @escaping (User?, GHError?) -> Void) {
        
        let endpoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, GHError.invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(nil, GHError.unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                completed(nil, GHError.invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil, GHError.invalidData)
                return
            }
            
            do {
                let decoder                 = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user                    = try decoder.decode(User.self, from: data)
                completed(user, nil)
            } catch {
                completed(nil, GHError.invalidData)
            }
        }
        
        task.resume()
    }
}

//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 09/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage

class NetworkManager {
    static let shared           = NetworkManager()
    private let baseUrl         = "https://api.github.com/users/"
    let cache                   = NSCache<NSString, UIImage>()
    private var runningRequests = [UUID: DataRequest]()
    
    private func cacheImage(_ image: UIImage, for key: String) {
        print("caching image")
        cache.setObject(image, forKey: key as NSString)
    }

    private func cachedImage(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    private init() {}
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) -> UUID? {
        if let cachedImage = cachedImage(for: urlString) {
            print("getting cached image")
            completion(cachedImage)
            return nil
        }
        let uuid = UUID()
        
        let request = AF.request(urlString)
            .validate(contentType: ["image/*"])
            .responseData { [weak self] response in
                guard let self = self else { return }
                defer { self.runningRequests.removeValue(forKey: uuid) }
                
                guard let data = response.data, let image = UIImage(data: data) else {
                    print("error in data")
                    completion(nil)
                    return
                }
                self.cacheImage(image, for: urlString)
                print("returning image")
                completion(image)
            }
        
        print("running request:", uuid)
        runningRequests[uuid] = request
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        print("cancelling request:", uuid)
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
    
//    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
//        let cacheKey    = NSString(string: urlString)
//
//        if let image    = cache.object(forKey: cacheKey) {
//            print("Cached Image")
//            completion(image)
//            return
//        }
//
//        guard let url   = URL(string: urlString) else {
//            print("url error")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//            guard let self      = self else { return }
//            if let _            = error { return }
//            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else { return }
//            guard let data      = data else { return }
//
//            guard let image     = UIImage(data: data) else { return }
//            self.cache.setObject(image, forKey: cacheKey)
//
//            print("downloaded image")
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        }
//        task.resume()
//    }
    
    
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

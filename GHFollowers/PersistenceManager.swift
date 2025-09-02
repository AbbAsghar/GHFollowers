//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 16/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GHError?) -> Void) {
        getFavorites { (favorites, error) in
            
            if let error = error {
                completed(error)
                return
            }
            
            guard let favorites = favorites else {
                completed(GHError.unableToGetFavorites)
                return
            }
            var retrievedFavorites = favorites
            
            switch actionType {
            case .add:
                guard !retrievedFavorites.contains(favorite) else {
                    completed(GHError.alreadyInFavorites)
                    return
                }
                
                retrievedFavorites.append(favorite)
                break
                
            case .remove:
                retrievedFavorites.removeAll { $0.login == favorite.login }
                break
            }
            
            completed(save(favorites: retrievedFavorites))
            
         }
    }
    
    
    static func getFavorites(completed: @escaping ([Follower]?, GHError?) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed([], nil)
            return
        }
        
        do {
            let decoder     = JSONDecoder()
            let favorites   = try decoder.decode([Follower].self, from: favoritesData)
            completed(favorites, nil)
        } catch {
            completed(nil, GHError.unableToGetFavorites)
        }
    }
    
    
    static func save(favorites: [Follower]) -> GHError? {
        do {
            let encoder     = JSONEncoder()
            let encodedFavorites   = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return GHError.unableToFavorite
        }
        
    }
}

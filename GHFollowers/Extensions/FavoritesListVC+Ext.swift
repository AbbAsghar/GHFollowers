//
//  FavoritesListVC+Ext.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 17/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as? FavoriteCell else {
            fatalError("Unable to dequeue cell in the VC")
        }
        
        if indexPath.row < favorites.count {
            cell.set(favorite: favorites[indexPath.row])
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if favorites.isEmpty {
            self.showEmptyStateView(with: "You have not added anyone to Favorites.\nAdd from the follower screen.", in: self.view)
        }
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] (error) in
            guard let self = self else { return }
            
            guard let error = error else { return }
            
            self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersListVC()
        
        destVC.username = favorite.login
        destVC.title    = favorite.login
        print("did select item \(favorite)")
        
        navigationController?.pushViewController(destVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//  FollowersListVC+Ext.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 11/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

extension FollowersListVC: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, FollowersListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username
        self.page = 1
        self.followers.removeAll()
        
        print("before removeAll \(self.filteredFollowers.count)")
        self.filteredFollowers.removeAll()
        print("after removeAll \(self.filteredFollowers.count)")
        
        self.hasMoreFollowers = true
        self.title = username
//        self.collectionView.scrollToTop()
        
        
//        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        print("Get Followers")
        print("\(self.username ?? "")")
        DispatchQueue.main.async {
            self.fetchFollowers(username: self.username, page: self.page)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell else {
            fatalError("Unable to dequeue cell in the VC")
        }
//        print("filter: \(filteredFollowers.count)")
//        print("inside cellforitemat \(indexPath.item)")
        if indexPath.item < filteredFollowers.count {
            cell.set(follower: filteredFollowers[indexPath.item])
        }
        else {
            print("index out of bounds")
        }
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("no. of items \(filteredFollowers.count)")
        return filteredFollowers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower        = filteredFollowers[indexPath.item]
        print("did select item at \(indexPath.item)")
        let destVC          = UserInfoVC()
        destVC.delegate     = self
        destVC.username     = follower.login
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            print("hasmorefollowers")
            fetchFollowers(username: username, page: page)
        }
        print("didenddragging")
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("inside textdidchange")
        if searchText.isEmpty {
            filteredFollowers   = followers
        } else {
            filteredFollowers   = followers.filter { item in
                item.login.lowercased().contains(searchText.lowercased())
            }
        }

        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print("data reloaded")
        }
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredFollowers = followers
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print("data reloaded")
        }
        print("cancel tapped")
    }
}

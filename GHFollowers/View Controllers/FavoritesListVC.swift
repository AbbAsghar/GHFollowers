//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 04/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    var tableView: UITableView!
    var favorites: [Follower]   = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("inside favoritesListVC")
        fetchFavorites()
    }
    
    
    func fetchFavorites() {
        
        PersistenceManager.getFavorites { [weak self] (favorites, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                return
            }
            
            guard let favorites = favorites else {
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error?.rawValue ?? "error", buttonTitle: "Ok")
                return
            }
            
            if favorites.isEmpty {
                self.showEmptyStateView(with: "You have not added anyone to Favorites.\nAdd from the follower screen.", in: self.view)
            }
                
            else {
                self.favorites = favorites
                print(favorites)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            }
            
        }
    }
    
    
    func configureViewController() {
        view.backgroundColor    = .white
//        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.rowHeight     = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor  = .white
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    

}

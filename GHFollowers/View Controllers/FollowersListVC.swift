//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 05/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

protocol FollowersListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowersListVC: UIViewController {

    var followers: [Follower]           = []
    var filteredFollowers: [Follower]   = []
    var page: Int                       = 1
    var hasMoreFollowers                = true
    let perPage: Int                    = 80
    var isLoadingMoreFollowers: Bool    = false
    
    var username: String!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        
//        configureToolbar()
        
        fetchFollowers(username: username, page: page)
    }
    
    
//    func configureToolbar() {
//        let toolbar = UIToolbar()
//        toolbar.translatesAutoresizingMaskIntoConstraints = false
//
//        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: nil, action: nil)
//        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: nil, action: nil)
////        let demo = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
//
//        toolbar.setItems([back, space, forward], animated: true)
//        toolbar.tintColor = UIColor.init(displayP3Red: 0, green: 0.75, blue: 0, alpha: 1)
////        toolbarItems?.remove(at: 0)
//
//
//        view.addSubview(toolbar)
//
//        NSLayoutConstraint.activate([
//            toolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            toolbar.trailingAnchor.constraint(equalTo:
//                view.safeAreaLayoutGuide.trailingAnchor),
//            toolbar.bottomAnchor.constraint(equalTo:
//                view.safeAreaLayoutGuide.bottomAnchor),
//            toolbar.heightAnchor.constraint(equalToConstant: 50)
//        ])
////        toolbar.setItems([back, demo, forward], animated: true)
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        configureCollectionView()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        let userInfoButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(getUserInfo))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItems                      = [userInfoButton, addButton]
//        navigationItem.rightBarButtonItem                       = userInfoButton
        
        view.backgroundColor                                    = .white
        navigationController?.navigationBar.prefersLargeTitles  = true
//        navigationController?.hidesBarsOnTap                    = true
        navigationController?.navigationBar.isTranslucent       = true
    }
    
    
    @objc func addToFavorites() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (user, error) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            guard let user = user else {
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error!.rawValue, buttonTitle: "Ok")
                return
            }
            
            let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
            
            PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                guard let self = self else { return }
                
                guard let error = error else {
                    print("\(favorite.login) added to favorites")
                    self.presentGHAlertOnMainThread(title: "Added to favorites", message: "Successfully added the user to your favorites", buttonTitle: "Ok")
                    return
                }
                
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    
    @objc func getUserInfo() {
        print("Profile button tapped")
        
        let destVC          = UserInfoVC()
        destVC.username     = username
        destVC.delegate     = self
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    func fetchFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        print("reached1")
        NetworkManager.shared.getFollowers(for: username, page: page, perPage: perPage) { [weak self] (followers, errorMessage) in
            guard let self = self else { return }
            
            guard let followers = followers else {
                self.presentGHAlertOnMainThread(title: "Bad stuff happened", message: errorMessage!.rawValue, buttonTitle: "Ok")
                DispatchQueue.main.async {
                    self.dismissLoadingView()
                    self.showEmptyStateView(with: "Bad stuff happened", in: self.view)
                }
                return
            }
            print(followers.count)
            self.followers.append(contentsOf: followers)
            self.filteredFollowers = self.followers
            print(self.filteredFollowers.count)
            
            //not reaching this line
            print("reached2")
            if followers.count < self.perPage {
                print("reached3")
                self.hasMoreFollowers = false
            }
            
            
            print("reached4")
            
            
            if self.followers.isEmpty {
                let message = "\(username) has no github followers"
                DispatchQueue.main.async {
                    self.showEmptyStateView(with: message, in: self.view)
                }
            }
            print("followerlistVC \(self.filteredFollowers.count)")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print("data reloaded")
                self.dismissLoadingView()
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    func configureSearchController() {
        let searchController                                    = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder                  = "Search for a username"
        navigationItem.searchController                         = searchController
        navigationItem.hidesSearchBarWhenScrolling              = false
        searchController.obscuresBackgroundDuringPresentation   = false
        searchController.searchBar.delegate                     = self
        searchController.searchBar.tintColor                    = UIColor.customGreenColor
//            UIColor.init(displayP3Red: 0, green: 0.75, blue: 0, alpha: 1)
//        searchController.searchBar.showsCancelButton            = true
    }
    
    
    func configureCollectionView() {
//        print("inside configurecollectionview")
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowlayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor  = .white
        
        collectionView.dataSource       = self
        collectionView.delegate         = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func createThreeColumnFlowlayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minSpacing: CGFloat         = 10
        let availableWidth              = width - (padding * 2) - (minSpacing * 2)
        let itemWidth
        = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 30)
        
        return flowLayout
    }
}

//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 18/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(user: User)
    func didTapGetFollowers(user: User)
}

class UserInfoVC: UIViewController {
    
    var username: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GHBodyLabel(textAlignment: .center)
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 180
    
    weak var delegate: FollowersListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        configureHeaderView()
        configureItemViewOne()
        configureItemViewTwo()
        configureDateLabel()

        fetchUserInfo(username: username)
    }
    
    
    func configureViewController() {
        view.backgroundColor                = UIColor.white
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
        navigationItem.title                = username
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    func fetchUserInfo(username: String) {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (user, errorMessage) in
            guard let self = self else { return }
            
            guard let user = user else {
                self.presentGHAlertOnMainThread(title: "Bad stuff happened", message: errorMessage!.rawValue, buttonTitle: "Ok")
                DispatchQueue.main.async {
                    self.dismissLoadingView()
                    self.showEmptyStateView(with: "Bad stuff happened", in: self.view)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.configureUIelements(with: user)
                self.dismissLoadingView()
            }
            print(user)
        }
    }
    
    
    func configureUIelements(with user: User) {
        let repoItemVC = GHReposItemVC(user: user)
        repoItemVC.delegate = self as UserInfoVCDelegate
        
        let followerItemVC = GHFollowerItemVC(user: user)
        followerItemVC.delegate = self as UserInfoVCDelegate
        
        self.add(childVC: GHUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC , to: self.itemViewOne)
        self.add(childVC: followerItemVC , to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
//        headerView.backgroundColor = UIColor.magenta
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureItemViewOne() {
        view.addSubview(itemViewOne)
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        itemViewOne.layer.cornerRadius  = 20
        
        NSLayoutConstraint.activate([
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    
    func configureItemViewTwo() {
        view.addSubview(itemViewTwo)
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        itemViewTwo.layer.cornerRadius  = 20
        
        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.backgroundColor = UIColor.clear
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}

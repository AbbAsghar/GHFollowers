//
//  GHReposItemVC.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 04/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHReposItemVC: GHUserInfoItemVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        
        actionButton.set(backgroundColor: .cyan, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(user: user)
    }
}

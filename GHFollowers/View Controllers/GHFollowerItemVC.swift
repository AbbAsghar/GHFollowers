//
//  GHFollowerItemVC.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 04/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHFollowerItemVC: GHUserInfoItemVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        
        actionButton.set(backgroundColor: .green, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(user: user)
    }
}

//
//  UserInfoVC+Ext.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 07/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import Foundation

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGHAlertOnMainThread(title: "Invalid Url", message: "The url attached to the profile seems wrong.", buttonTitle: "Ok")
            return
        }
        print("GitHub Profile button tapped")
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(user: User) {
        print("Get Followers button tapped")
        guard user.followers != 0 else {
            DispatchQueue.main.async {
                self.presentGHAlertOnMainThread(title: "No Followers", message: "\(user.login) has no followers.", buttonTitle: "Ok")
            }
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}

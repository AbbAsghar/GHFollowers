//
//  User.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 09/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import Foundation

struct User: Codable {
    let login:      String
    let avatarUrl:  String
    var name:       String?
    var bio:        String?
    var location:   String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl:    String
    let following:  Int
    let followers:  Int
    let createdAt:  String
}

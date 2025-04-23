//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 10/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID      = "FollowerCell"
    
    let avatarImageView     = GHAvatarImageView(frame: .zero)
    let usernameLabel       = GHTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("preparing for reuse")
        self.avatarImageView.image = UIImage(named: "avatar-placeholder")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        print("setting follower details")
        usernameLabel.text      = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }

    
    private func configure() {
//        print("inside configure followercell")
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}

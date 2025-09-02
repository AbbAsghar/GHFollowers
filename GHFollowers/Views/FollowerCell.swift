//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 10/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit
//import Alamofire
//import AlamofireImage

class FollowerCell: UICollectionViewCell {
    
//    let cache               = NetworkManager.shared.cache
    static let reuseID      = "FollowerCell"
    var cellRequestId: UUID?
    let avatarImageView     = GHAvatarImageView(frame: .zero)
    let usernameLabel       = GHTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("preparing for reuse")
//        self.currentItemID = nil
        self.avatarImageView.image = UIImage(named: "avatar-placeholder")
        if let requestId = self.cellRequestId {
            NetworkManager.shared.cancelLoad(requestId)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        print("setting follower details")
//        currentItemID           = follower.avatarUrl
        usernameLabel.text      = follower.login
        
//        avatarImageView.downloadImage(from: follower.avatarUrl)
        
        if let requestId = self.cellRequestId {
            NetworkManager.shared.cancelLoad(requestId)
        }
        
        cellRequestId = NetworkManager.shared.loadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            
            guard let image = image else {
                return
            }
            
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
        
//        NetworkManager.shared.loadImage(from: follower.avatarUrl) { [weak self] image in
//            guard let self = self else { return }
////            guard self.currentItemID == follower.avatarUrl else { return }
//            self.avatarImageView.image = image
//        }
//        loadImage(from: follower.avatarUrl) { [weak self] image in
//            guard let self = self else { return }
////            guard self.currentItemID == follower.avatarUrl else { return }
//            self.avatarImageView.image = image
//        }
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

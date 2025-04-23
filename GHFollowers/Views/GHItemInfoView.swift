//
//  GHItemInfoView.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 03/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}


class GHItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = GHTitleLabel(textAlignment: .left, fontSize: 16)
    let countLabel = GHTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 22),
            symbolImageView.heightAnchor.constraint(equalToConstant: 22),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    func set(itemInfoType: ItemInfoType, with count: Int) {
        switch itemInfoType {
        case .followers:
            symbolImageView.image = UIImage(named: "followers")
            titleLabel.text = "Followers"
            
        case .repos:
            symbolImageView.image = UIImage(named: "repos")
            titleLabel.text = "Public Repos"
            
        case .gists:
            symbolImageView.image = UIImage(named: "gists")
            titleLabel.text = "Public Gists"
            
        case .following:
            symbolImageView.image = UIImage(named: "following")
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }
    
}

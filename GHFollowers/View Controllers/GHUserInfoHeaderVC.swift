//
//  GHUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 20/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHUserInfoHeaderVC: UIViewController {
    
    let avatarImageView     = GHAvatarImageView(frame: .zero)
    let usernameLabel       = GHTitleLabel(textAlignment: .left, fontSize: 30)
    let nameLabel           = GHSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = GHSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GHBodyLabel(textAlignment: .left)
    
    let padding: CGFloat            = 20
    let textImagePadding: CGFloat   = 12
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAvatarImageView()
        configureUsernameLabel()
        configureNameLabel()
        configureLocationImageView()
        configureLocationLabel()
        configureBioLabel()
        
    }
    
    
    func configureAvatarImageView() {
        view.addSubview(avatarImageView)
        
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        avatarImageView.addGestureRecognizer(imageTap)
        
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.layer.cornerRadius  = 15
        avatarImageView.downloadImage(from: user.avatarUrl)
    }
    
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        
        let tempView        = UIView(frame: (self.parent?.view.bounds)!)
        let newImageView    = UIImageView(image: avatarImageView.image)
        
        newImageView.frame  = CGRect(x: view.bounds.minX, y: view.bounds.midY + 120, width: view.bounds.width, height: view.bounds.width)
        
        newImageView.layer.cornerRadius = 30
        
        newImageView.clipsToBounds = true
        newImageView.backgroundColor = UIColor.translucentBackground
//            UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        newImageView.contentMode = .scaleAspectFit
//        newImageView.isUserInteractionEnabled = true
        
        tempView.addSubview(newImageView)
        tempView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        tempView.addGestureRecognizer(tap)
        
        UIView.transition(with: (self.parent?.view)!, duration: 0.35, options: [.transitionCrossDissolve, .curveEaseIn], animations: { self.parent?.view.addSubview(tempView) }, completion: nil)

//        UIApplication.shared.windows.first?.rootViewController?.navigationController?.isNavigationBarHidden = true
//        UIApplication.shared.windows.first?.rootViewController?.tabBarController?.tabBar.isHidden = true
    }
    
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
//        UIApplication.shared.windows.first?.rootViewController?.navigationController?.isNavigationBarHidden = false
//        UIApplication.shared.windows.first?.rootViewController?.tabBarController?.tabBar.isHidden = false
        //        sender.view?.removeFromSuperview()
        
//        avatarImageView.isUserInteractionEnabled = true
        sender.view?.isUserInteractionEnabled = true
        
        UIView.transition(with: (self.parent?.view)!, duration: 0.35, options: [.transitionCrossDissolve, .curveEaseIn], animations: { sender.view?.removeFromSuperview() }, completion: nil)
    }
    
    
    func configureUsernameLabel() {
        view.addSubview(usernameLabel)
        usernameLabel.text  = user.login
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    
    func configureNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.text  = user.name ?? ""
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    func configureLocationImageView() {
        view.addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.image     = UIImage(named: "location")
        
        NSLayoutConstraint.activate([
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    func configureLocationLabel() {
        view.addSubview(locationLabel)
        locationLabel.text      = user.location ?? "Location not set"
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    func configureBioLabel() {
        view.addSubview(bioLabel)
        bioLabel.text           = user.bio ?? "Bio not set"
        bioLabel.numberOfLines  = 3
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

}

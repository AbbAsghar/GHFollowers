//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 04/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView       = UIImageView()
    let userNameTextField   = GHTextField()
    let callToActionButton  = GHButton(backgroundColor: UIColor.customGreenColor, title: "Get Followers")
//        UIColor.init(displayP3Red: 0, green: 0.75, blue: 0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
//        print(FileManager.default.urls(for: .documentDirectory , in: .userDomainMask)[0])
    }
    
    
    @objc func pushFollowerListVC() {
        guard !userNameTextField.text!.isEmpty else {
//            print("No username entered.")
            presentGHAlertOnMainThread(title: "No Username", message: "Enter a username to look for.", buttonTitle: "Ok")
            return
        }
        
        let followerListVC      = FollowersListVC()
        followerListVC.username = userNameTextField.text
        followerListVC.title    = userNameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
        userNameTextField.text  = ""
        userNameTextField.placeholder = "Enter a username"
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image     = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    
    func configureTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

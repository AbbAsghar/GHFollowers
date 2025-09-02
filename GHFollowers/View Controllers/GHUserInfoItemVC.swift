//
//  GHItemInfoVC.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 03/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHUserInfoItemVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne     = GHItemInfoView()
    let itemInfoViewTwo     = GHItemInfoView()
    let actionButton        = GHButton()
    let padding: CGFloat    = 20
    
    var user: User!
    weak var delegate: UserInfoVCDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user           = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureViewController()
        
        configureStackView()
        configureActionButton()
    }
    
    
    func disableView() {
        view.isUserInteractionEnabled = false
    }
    
    
    func configureViewController() {
        view.backgroundColor    = UIColor.lightGray
        view.layer.cornerRadius = 18
    }
    
    
    func configureStackView() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution  = .equalSpacing
        stackView.alignment     = .center
        stackView.axis          = .horizontal
        stackView.spacing       = 10
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    
    func configureActionButton() {
        view.addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func actionButtonTapped() { }
    
}

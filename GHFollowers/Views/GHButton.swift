//
//  GHButton.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 04/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor    = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    private func configure() {
        layer.cornerRadius      = 10
        
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
}

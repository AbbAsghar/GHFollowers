//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 04/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.lightGray.cgColor
        
        textColor                   = .black
        tintColor                   = .black
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = UIColor.white
        autocorrectionType          = .no
        returnKeyType               = .done
        
//        placeholder                 = "Enter a username"
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}

//
//  GHSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 20/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font                   = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        textColor                   = UIColor.darkGray
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}

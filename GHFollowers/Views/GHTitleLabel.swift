//
//  GHTitleLabel.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 05/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment          = textAlignment
        self.font                   = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        textColor                   = UIColor.black
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.85
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}

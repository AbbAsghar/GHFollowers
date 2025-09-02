//
//  GHBodyLabel.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 05/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

class GHBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment          = textAlignment
        configure()
    }
    
    private func configure() {
        textColor                   = UIColor.darkGray
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.7
        lineBreakMode               = .byWordWrapping
        font                        = UIFont.preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

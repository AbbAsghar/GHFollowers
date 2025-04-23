//
//  UIScrollView+Ext.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 17/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToTop() {
//        contentOffset.y = .leastNonzeroMagnitude
        setContentOffset(.zero, animated: true)
    }
}

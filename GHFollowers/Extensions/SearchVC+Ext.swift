//
//  SearchVC+Ext.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 06/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
}


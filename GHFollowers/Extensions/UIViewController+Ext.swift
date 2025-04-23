//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 06/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import UIKit
import SafariServices
fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGHAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GHAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle      = .overFullScreen
            alertVC.modalTransitionStyle        = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = UIColor.customGreenColor
//            UIColor.init(displayP3Red: 0, green: 0.75, blue: 0, alpha: 1)
        present(safariVC, animated: true, completion: nil)
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .white
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.3) {
            containerView.alpha         = 0.8
        }
        
        let activityIndicator       = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color     = .gray
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView   = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView      = GHEmptyStateView(message: message)
        
        emptyStateView.frame    = view.bounds
//        emptyStateView.backgroundColor = .white
        view.addSubview(emptyStateView)
        view.bringSubviewToFront(emptyStateView)
    }
}

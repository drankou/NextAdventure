//
//  UIViewController+UIActivityIndicator.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 07.02.2021.
//

import UIKit

var activityIndicatorView: UIView?

extension UIViewController {
    func showActivityIndicator(view: UIView) {
        let containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        view.addSubview(containerView)
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        containerView.addSubview(activityIndicator)
        activityIndicator.color = .systemGray2
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicatorView = containerView
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            if let view = activityIndicatorView?.superview {
                UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    activityIndicatorView?.removeFromSuperview()
                })
            }
            
            activityIndicatorView = nil
        }
    }
}

//
//  UIView+Loading.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import UIKit

class LoadingContainer: UIView {}

extension UIView {

    func startLoading() {
        stopLoading()
        let loadingSpinner: UIActivityIndicatorView = UIActivityIndicatorView()
        loadingSpinner.color = .gray
        let containerView: LoadingContainer = LoadingContainer()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        containerView.addSubview(loadingSpinner)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loadingSpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        loadingSpinner.startAnimating()
        self.layoutIfNeeded()
    }
    
    func stopLoading() {
        for subview in self.subviews {
            if let containerView = subview as? LoadingContainer {
                containerView.removeFromSuperview()
                return
            }
        }
    }
}

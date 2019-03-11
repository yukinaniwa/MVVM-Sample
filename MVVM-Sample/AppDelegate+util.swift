//
//  AppDelegate+util.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import Foundation
import SwiftyBeaver


let log = SwiftyBeaver.self

extension AppDelegate {
    func setup() {
        log.addDestination(ConsoleDestination())
    }
}

extension AppDelegate {
    var indicatorViewTag: Int {
        return -9999
    }
    
    func startIndicator() {
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        activityIndicator.tag = self.indicatorViewTag
        
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge

        activityIndicator.startAnimating()
        
        self.window?.addSubview(activityIndicator)
        
        if let window = self.window {
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                window.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor),
                window.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor),
                window.widthAnchor.constraint(equalTo: activityIndicator.widthAnchor),
                window.heightAnchor.constraint(equalTo: activityIndicator.heightAnchor),
                ])
        }
    }
    
    func stopIndicator() {
        if let view = self.window?.viewWithTag(self.indicatorViewTag) as? UIActivityIndicatorView {
            view.stopAnimating()
            view.removeFromSuperview()
        }
    }
}

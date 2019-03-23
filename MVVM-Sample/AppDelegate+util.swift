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
    
    func startIndicator() {
        
        DispatchQueue.main.async {
            if self.indicator == nil {
                self.indicator = UIActivityIndicatorView()
                self.indicator?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                
                self.indicator?.style = UIActivityIndicatorView.Style.whiteLarge
            }
            self.indicator?.startAnimating()
            
            guard let indicator = self.indicator, let window = self.window else {
                preconditionFailure()
            }
            
            window.addSubview(indicator)
            indicator.bringSubviewToFront(window)
            
            indicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                window.centerXAnchor.constraint(equalTo: indicator.centerXAnchor),
                window.centerYAnchor.constraint(equalTo: indicator.centerYAnchor),
                window.widthAnchor.constraint(equalTo: indicator.widthAnchor),
                window.heightAnchor.constraint(equalTo: indicator.heightAnchor),
                ])
        }
    }
    
    func stopIndicator() {
        
        DispatchQueue.main.async {
            guard let indicator = self.indicator else {
                preconditionFailure()
            }
            
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
}

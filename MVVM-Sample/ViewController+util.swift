//
//  ViewController+util.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import UIKit

protocol Instantiatable {
}

extension Instantiatable where Self: UIViewController {
    
    static func loadFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            preconditionFailure("Error: Load ViewController")
        }
        return vc
    }
}


extension UIViewController {
    var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            preconditionFailure("Error: appDelegate")
        }
        
        return appDelegate
    }
}

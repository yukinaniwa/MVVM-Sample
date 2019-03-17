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

extension UIViewController {
    func alert(message: String) {
        let alert: UIAlertController = UIAlertController(title: nil, message: message, preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            log.verbose("alert ok")
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            log.verbose("alert cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

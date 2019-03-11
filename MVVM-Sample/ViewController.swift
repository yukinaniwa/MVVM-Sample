//
//  ViewController.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Instantiatable {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func didTapLoginButton(_ sender: Any) {
        log.verbose("didTapLoginButton.")
        
        let vc = LoginViewController.loadFromStoryboard()
        let loginViewController = UINavigationController(rootViewController: vc)
        
        self.present(loginViewController, animated: true, completion: nil)
    }
}

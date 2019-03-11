//
//  LoginViewController.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, Instantiatable {

    private var loginViewModel: LoginViewModelType = LoginViewModel()
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        log.verbose("didTapDoneButton.")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        log.verbose("didTapLoginButton.")
        
        self.loginViewModel.inputs.set(userId: self.idTextField.text ?? "")
        self.loginViewModel.inputs.set(userId: self.passwordTextField.text ?? "")
        
        self.appDelegate.startIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.appDelegate.stopIndicator()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

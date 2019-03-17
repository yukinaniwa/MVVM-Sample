//
//  LoginViewController.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, Instantiatable {

    private var loginViewModel: LoginViewModelType = LoginViewModel()
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bindViewModel()
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        log.verbose("didTapDoneButton.")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        log.verbose("didTapLoginButton.")
        
        self.loginViewModel.inputs.set(userId: self.idTextField.text ?? "")
        self.loginViewModel.inputs.set(userId: self.passwordTextField.text ?? "")
        

        self.fetchViewModel()
    }

}

extension LoginViewController {
    func fetchViewModel() {
        self.appDelegate.startIndicator()
        
        self.loginViewModel.inputs.fetch()
    }
    
    func bindViewModel() {
        self.loginViewModel.outputs.fetchResult.emit(onNext: { [weak self] (fetchResult) in
            
            guard let `self` = self else { return }
            
            self.appDelegate.stopIndicator()
            
            log.verbose("fetchResult: \(fetchResult)")
            
            switch fetchResult {
            case .success:
                let vc = TopViewController.loadFromStoryboard()
                let topViewController = UINavigationController(rootViewController: vc)
                
                self.present(topViewController, animated: true, completion: nil)
            case .cancel:
                break
            case .error(let error):
                self.alert(message: "\(error.code), \(error.message)")
            }
            
        }).disposed(by: disposeBag)
    }
}

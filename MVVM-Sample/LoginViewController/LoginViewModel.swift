//
//  LoginViewModel.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import Foundation

protocol LoginViewModelInputs {
    func set(userId: String)
    func set(password: String)
}

protocol LoginViewModelOutputs {
    
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs {

    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    
    private var userId: String = ""
    private var password: String = ""
    
    // MARK: - Inputs
    func set(userId: String) {
        self.userId = userId
    }
    
    func set(password: String) {
        self.password = password
    }
    
    // MARK: - Outputs
    
}

//
//  LoginViewModel.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelInputs {
    func set(userId: String)
    func set(password: String)
    
    func fetch()
}

protocol LoginViewModelOutputs {
    var fetchResult:Signal<FetchResult> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs {
    
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    
    private let disposeBag = DisposeBag()
    
    private var userId: String = ""
    private var password: String = ""
    
    private var loginResponseModel: ResponseModel.LoginResponseModel?
    private var fetchResultRelay = PublishRelay<FetchResult>()
    
    // MARK: - Inputs
    func set(userId: String) {
        self.userId = userId
    }
    
    func set(password: String) {
        self.password = password
    }
    
    // MARK: - Outputs
    private(set) lazy var fetchResult:Signal<FetchResult> = {
        return self.fetchResultRelay.asSignal()
    }()
    
    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            
            let jsonString = """
                {
                  "userToken": "user_xxxxxxxxxx"
                }
            """
            
            guard let responseData = jsonString.data(using: .utf8) else {
                self.fetchResultRelay.accept(.error(error: ResponseError(code: 500, message: "json perse error")))
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(ResponseModel.LoginResponseModel.self, from: responseData)
                
                self.loginResponseModel = responseModel
                self.fetchResultRelay.accept(.success)
            } catch {
                self.fetchResultRelay.accept(.error(error: ResponseError(error: error)))
            }
        }
    }
}

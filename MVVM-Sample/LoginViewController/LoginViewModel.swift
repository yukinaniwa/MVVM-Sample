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
            self.fetchResultRelay.accept(.success)
        }
    }
}

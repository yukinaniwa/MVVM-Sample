//
//  TopViewModel.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TopViewModelInputs {
    func fetch(processTime: TimeInterval, isForceError: Bool)
}

protocol TopViewModelOutputs {
    var fetchResult:Signal<FetchResult> { get }
    
    var topResponseModel: ResponseModel.TopResponseModel? { get }
}

protocol TopViewModelType {
    var inputs: TopViewModelInputs { get }
    var outputs: TopViewModelOutputs { get }
}

final class TopViewModel: TopViewModelType, TopViewModelInputs, TopViewModelOutputs {
    
    var inputs: TopViewModelInputs { return self }
    var outputs: TopViewModelOutputs { return self }
    
    private let disposeBag = DisposeBag()
    
    var topResponseModel: ResponseModel.TopResponseModel?
    private var fetchResultRelay = PublishRelay<FetchResult>()
    
    // MARK: - Inputs
    
    // MARK: - Outputs
    private(set) lazy var fetchResult:Signal<FetchResult> = {
        return self.fetchResultRelay.asSignal()
    }()
    
    func fetch(processTime: TimeInterval = 2.0, isForceError: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + processTime) {
            
            if isForceError == true {
                self.fetchResultRelay.accept(.error(error: ResponseError(code: 400, message: "error message.")))
                return
            }
            
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
                let responseModel = try JSONDecoder().decode(ResponseModel.TopResponseModel.self, from: responseData)
                
                self.topResponseModel = responseModel
                self.fetchResultRelay.accept(.success)
            } catch {
                self.fetchResultRelay.accept(.error(error: ResponseError(error: error)))
            }
        }
    }
}

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
}

protocol TopViewModelType {
    var inputs: TopViewModelInputs { get }
    var outputs: TopViewModelOutputs { get }
}

final class TopViewModel: TopViewModelType, TopViewModelInputs, TopViewModelOutputs {
    
    var inputs: TopViewModelInputs { return self }
    var outputs: TopViewModelOutputs { return self }
    
    private let disposeBag = DisposeBag()
    
    private var fetchResultRelay = PublishRelay<FetchResult>()
    
    // MARK: - Inputs
    
    // MARK: - Outputs
    private(set) lazy var fetchResult:Signal<FetchResult> = {
        return self.fetchResultRelay.asSignal()
    }()
    
    func fetch(processTime: TimeInterval = 2.0, isForceError: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + processTime) {
            self.fetchResultRelay.accept(.success)
        }
    }
}

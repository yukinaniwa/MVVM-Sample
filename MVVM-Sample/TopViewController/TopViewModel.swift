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
    func fetch()
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
    
    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            self.fetchResultRelay.accept(.success)
        }
    }
}

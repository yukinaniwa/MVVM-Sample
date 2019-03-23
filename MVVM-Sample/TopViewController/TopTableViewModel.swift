//
//  TopTableViewModel.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/11.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TopTableViewModelInputs {
    
    func set(isFinishModelAA: Bool)
    func set(isFinishModelBB: Bool)
    func set(isFinishModelCC: Bool)
    
    func set(isFinishModelZip: Bool)
    func set(isFinishModelCombineLatest: Bool)
}

protocol TopTableViewModelOutputs {
    var isFinishModelAA: Bool { get }
    var isFinishModelBB: Bool { get }
    var isFinishModelCC: Bool { get }
    
    var isFinishModelZip: Bool { get }
    var isFinishModelCombineLatest: Bool { get }
}

protocol TopTableViewModelType {
    var inputs: TopTableViewModelInputs { get }
    var outputs: TopTableViewModelOutputs { get }
}

final class TopTableViewModel: TopTableViewModelType, TopTableViewModelInputs, TopTableViewModelOutputs {
    
    var inputs: TopTableViewModelInputs { return self }
    var outputs: TopTableViewModelOutputs { return self }
    
    // MARK: - Inputs
    
    func set(isFinishModelAA: Bool) {
        self.isFinishModelAA = isFinishModelAA
    }
    
    func set(isFinishModelBB: Bool) {
        self.isFinishModelBB = isFinishModelBB
    }
    
    func set(isFinishModelCC: Bool) {
        self.isFinishModelCC = isFinishModelCC
    }
    
    func set(isFinishModelZip: Bool) {
        self.isFinishModelZip = isFinishModelZip
    }
    
    func set(isFinishModelCombineLatest: Bool) {
        self.isFinishModelCombineLatest = isFinishModelCombineLatest
    }
    
    // MARK: - Outputs
    
    var isFinishModelAA: Bool = false
    var isFinishModelBB: Bool = false
    var isFinishModelCC: Bool = false
    
    var isFinishModelZip: Bool = false
    var isFinishModelCombineLatest: Bool = false
    
}

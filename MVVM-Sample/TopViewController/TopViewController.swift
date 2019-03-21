//
//  TopViewController.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/17.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TopViewController: UIViewController, Instantiatable {

    private var topViewModelAA: TopViewModelType = TopViewModel()
    private var topViewModelBB: TopViewModelType = TopViewModel()
    private var topViewModelCC: TopViewModelType = TopViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel()
    }
    
    @IBAction private func didTapedFetch(_ sender: Any) {
        self.fetchViewModel()
    }
}

// MARK: - viewModel

extension TopViewController {
    private func bindViewModel() {
        
        self.appDelegate.startIndicator()
        
        Signal.zip(
            self.topViewModelAA.outputs.fetchResult,
            self.topViewModelBB.outputs.fetchResult,
            self.topViewModelCC.outputs.fetchResult
            ).emit(onNext: { [weak self] (resultAA, resultBB, resultCC) in
                
                guard let `self` = self else { return }
                
                self.appDelegate.stopIndicator()
                
                log.verbose("topResult: Zip: \(resultAA),\(resultBB),\(resultAA)")
            }).disposed(by: disposeBag)
        
        self.topViewModelAA.outputs.fetchResult.emit(onNext: { [weak self] (fetchResult) in
            
            guard let `self` = self else { return }
            
            log.verbose("topResult: AA: \(fetchResult)")
            
            switch fetchResult {
            case .success:
                break
            case .cancel:
                break
            case .error(let error):
                self.alert(message: "\(error.code), \(error.message)")
            }
            
        }).disposed(by: disposeBag)
        
        self.topViewModelBB.outputs.fetchResult.emit(onNext: { [weak self] (fetchResult) in
            
            guard let `self` = self else { return }
            
            log.verbose("topResult: BB: \(fetchResult)")
            
            switch fetchResult {
            case .success:
                break
            case .cancel:
                break
            case .error(let error):
                self.alert(message: "\(error.code), \(error.message)")
            }
            
        }).disposed(by: disposeBag)
        
        self.topViewModelCC.outputs.fetchResult.emit(onNext: { [weak self] (fetchResult) in
            
            guard let `self` = self else { return }
            
            log.verbose("topResult: CC: \(fetchResult)")
            
            switch fetchResult {
            case .success:
                break
            case .cancel:
                break
            case .error(let error):
                self.alert(message: "\(error.code), \(error.message)")
            }
            
        }).disposed(by: disposeBag)
    }
    
    private func fetchViewModel() {
        
        self.appDelegate.startIndicator()
        
        self.topViewModelAA.inputs.fetch(processTime: 1.0, isForceError: false)
        self.topViewModelBB.inputs.fetch(processTime: 1.5, isForceError: false)
        self.topViewModelCC.inputs.fetch(processTime: 2.2, isForceError: false)
    }
}

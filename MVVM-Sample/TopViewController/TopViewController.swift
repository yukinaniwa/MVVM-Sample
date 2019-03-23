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

final class TopViewController: UIViewController, Instantiatable {

    private enum Sections: Int, CaseIterable {
        case signal
        case signalZip
        case signalCombineLatest
        
        var rows: Int {
            switch self {
            case .signal:
                return SignalRows.allCases.count
            case .signalZip:
                return SignalZipRows.allCases.count
            case .signalCombineLatest:
                return SignalCombineLaatestRows.allCases.count
            }
        }
        
        var sectionTitle: String {
            switch self {
            case .signal:
                return "signal"
            case .signalZip:
                return "signalZip"
            case .signalCombineLatest:
                return "signalCombineLatest"
            }
        }
    }
    
    private enum SignalRows: Int, CaseIterable {
        case modelAA
        case modelBB
        case modelCC
        
        var title: String {
            switch self {
            case .modelAA:
                return ".modelAA"
            case .modelBB:
                return ".modelBB"
            case .modelCC:
                return ".modelCC"
            }
        }
    }
    
    private enum SignalZipRows: Int, CaseIterable {
        case zipModel
        
        var title: String {
            switch self {
            case .zipModel:
                return ".zipModel"
            }
        }
    }
    
    private enum SignalCombineLaatestRows: Int, CaseIterable {
        case combineLatestModel
        
        var title: String {
            switch self {
            case .combineLatestModel:
                return ".combineLatestModel"
            }
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var topTableViewModel: TopTableViewModelType = TopTableViewModel()
    
    private var topViewModelAA: TopViewModelType = TopViewModel()
    private var topViewModelBB: TopViewModelType = TopViewModel()
    private var topViewModelCC: TopViewModelType = TopViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 42
        self.tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        self.tableView.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.bindViewModel()
        self.fetchViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

// MARK: - UITableViewDelegate

extension TopViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        guard let section = Sections(rawValue: section) else {
            preconditionFailure()
        }
        
        let label = UILabel()
        
        label.backgroundColor = UIColor(hex: "F2BD2D")
        
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        
        label.text = "  \(section.sectionTitle)"
        
        return label
    }
}

// MARK: - UITableViewDataSource

extension TopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = Sections(rawValue: section) else {
            preconditionFailure()
        }
        
        return section.rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomCell else {
            let cell = UITableViewCell()
            return cell
        }
        
        guard let section = Sections(rawValue: indexPath.section) else {
            preconditionFailure()
        }
        
        switch section {
        case .signal:
            
            guard let row = SignalRows(rawValue: indexPath.row) else {
                preconditionFailure()
            }
            
            cell.descriptionLabel.text = row.title
            
            switch row {
            case .modelAA:
                cell.updateCells(enable: !self.topTableViewModel.outputs.isFinishModelAA)
            case .modelBB:
                cell.updateCells(enable: !self.topTableViewModel.outputs.isFinishModelBB)
            case .modelCC:
                cell.updateCells(enable: !self.topTableViewModel.outputs.isFinishModelCC)
            }
        case .signalZip:
            
            guard let row = SignalZipRows(rawValue: indexPath.row) else {
                preconditionFailure()
            }
            
            cell.descriptionLabel.text = row.title
            
            cell.updateCells(enable: !self.topTableViewModel.outputs.isFinishModelZip)
        case .signalCombineLatest:
            
            guard let row = SignalCombineLaatestRows(rawValue: indexPath.row) else {
                preconditionFailure()
            }
            
            cell.descriptionLabel.text = row.title
            
            cell.updateCells(enable: !self.topTableViewModel.outputs.isFinishModelCombineLatest)
        }
        
        return cell
    }
}

// MARK: - viewModel

extension TopViewController {
    private func bindViewModel() {
        
        self.appDelegate.startIndicator()
        
        Signal.combineLatest(
            self.topViewModelAA.outputs.fetchResult,
            self.topViewModelBB.outputs.fetchResult,
            self.topViewModelCC.outputs.fetchResult
            ).emit(onNext: { [weak self] (resultAA, resultBB, resultCC) in
                
                guard let `self` = self else { return }
                
                self.appDelegate.stopIndicator()
                
                log.verbose("topResult: combineLatest: \(resultAA),\(resultBB),\(resultAA)")
            }).disposed(by: disposeBag)

        
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

final class CustomCell: UITableViewCell {
    @IBOutlet weak var skeletonView: SkeletonView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func updateCells(enable: Bool) {
        
        self.skeletonView.isHidden = !enable
        self.descriptionLabel.isHidden = !enable
        
        if enable == true {
            self.skeletonView.startAnimating()
        } else {
            self.skeletonView.stopAnimating()
        }
    }
}

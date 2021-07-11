//
//  ViewModelProtocol.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 12.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelProtocol: AnyObject {
    
    associatedtype Model = Decodable
    
    var data: BehaviorRelay<[Model]> { get }
    var allData: BehaviorRelay<[Model]> { get }
    var isGettingData: BehaviorRelay<Bool> { get }
    var presentErrorSubject: PublishSubject<String> { get }
    var searchTerm: String { get set }
    var disposeBag: DisposeBag { get }
    var timer: Disposable? { get set }
    var isDisplaying: Bool { get set }
    init()
    func getData()
    func search(searchTerm: String)
    func startTimer()
    func stopTimer()
    
}

extension ViewModelProtocol {
    
    init() {
        self.init()
        UIApplication.rx.didEnterBackground.subscribe { [weak self] _ in
            self?.stopTimer()
        }.disposed(by: disposeBag)

        UIApplication.rx.willEnterForeground.subscribe { [weak self] _ in
            if self?.isDisplaying ?? false {
                self?.startTimer()
            }
        }.disposed(by: disposeBag)
    }
    
    func startTimer() {
        getData()
        stopTimer()
        timer = Observable<Int>.interval(.seconds(8), scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.getData()
            }
    }
    
    func stopTimer() {
        timer?.dispose()
        timer = nil
    }
    
}

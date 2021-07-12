//
//  TimerProtocol.swift
//  YahooStocks
//
//  Created by Ulas Sancak [Mirsisbilgiteknolojileri] on 12.07.2021.
//

import Foundation
import RxSwift

protocol TimerProtocol: AnyObject {
    
    init()
    var disposeBag: DisposeBag { get }
    var timer: Disposable? { get set }
    var isDisplaying: Bool { get set }
    func startTimer()
    func stopTimer()
    func fire()
    
}

extension TimerProtocol {
    
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
        fire()
        stopTimer()
        timer = Observable<Int>.interval(.seconds(8), scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.fire()
            }
    }
    
    func stopTimer() {
        timer?.dispose()
        timer = nil
    }
    
}

//
//  MarketSummaryViewModel.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class MarketSummaryViewModel: ViewModelProtocol, TimerProtocol, SearchProtocol {
    
    let filteredData = BehaviorRelay<[Market]>(value: [])
    let allData = BehaviorRelay<[Market]>(value: [])
    let isGettingData = BehaviorRelay<Bool>(value: false)
    let presentErrorSubject = PublishSubject<String>()
    var searchTerm: String = ""
    let disposeBag = DisposeBag()
    var timer: Disposable?
    var isDisplaying: Bool = false {
        didSet {
            isDisplaying ? startTimer() : stopTimer()
        }
    }
    
    deinit {
        timer?.dispose()
    }
    
    func getData() {
        isGettingData.accept(true)
        let api = MarketSummaryAPI()
        api.rx_start().subscribe { [weak self] response in
            self?.allData.accept(response.responseModel?.marketSummaryAndSparkResponse.result ?? [])
            self?.search(searchTerm: self?.searchTerm ?? "")
        } onError: { [weak self] error in
            self?.presentErrorSubject.onNext(error.localizedDescription)
        } onCompleted: { [weak self] in
            self?.isGettingData.accept(false)
        }.disposed(by: disposeBag)
    }
    
    func search(searchTerm: String = "") {
        self.searchTerm = searchTerm
        guard !searchTerm.isEmpty else {
            filteredData.accept(allData.value)
            return
        }
        filteredData.accept(allData.value.filter({ $0.name.contains(searchTerm) }))
    }
    
    func fire() {
        getData()
    }
    
}

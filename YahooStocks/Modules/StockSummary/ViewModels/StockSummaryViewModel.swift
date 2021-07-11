//
//  StockSummaryViewModel.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class StockSummaryViewModel: ViewModelProtocol {
        
    let data = BehaviorRelay<[[String: String]]>(value: [])
    let allData = BehaviorRelay<[[String: String]]>(value: [])
    let isGettingData = BehaviorRelay<Bool>(value: false)
    let presentErrorSubject = PublishSubject<String>()
    var searchTerm: String = ""
    let disposeBag = DisposeBag()
    var timer: Disposable?
    var isDisplaying: Bool = false {
        didSet {
            if isDisplaying {
                getData()
            }
        }
    }
    
    private let symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    func getData() {
        isGettingData.accept(true)
        let api = StockSummaryAPI(parameters: StockSummaryRequestModel(symbol: symbol))
        api.rx_start().subscribe { [weak self] response in
            self?.isGettingData.accept(false)
            guard let price = response.responseModel?.price else { return }
            var allData = [
                ["title": "Symbol", "value": price.symbol],
                ["title": "Name", "value": price.shortName],
                ["title": "Price", "value": price.regularMarketPrice.fmt],
                ["title": "Open", "value": price.regularMarketOpen.fmt],
                ["title": "High", "value": price.regularMarketDayHigh.fmt],
                ["title": "Low", "value": price.regularMarketDayLow.fmt]
            ]
            if price.marketCap.raw != 0 {
                allData.append(["title": "Volume", "value": price.regularMarketVolume.fmt])
            }
            if price.marketCap.raw != 0 {
                allData.append(["title": "Market Cap", "value": price.marketCap.fmt])
            }
            self?.allData.accept(allData)
            self?.search(searchTerm: self?.searchTerm ?? "")
        } onError: { [weak self] error in
            self?.presentErrorSubject.onNext(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func search(searchTerm: String = "") {
        self.searchTerm = searchTerm
        guard !searchTerm.isEmpty else {
            data.accept(allData.value)
            return
        }
        data.accept(allData.value.filter({ $0["title"]?.contains(searchTerm) ?? false }))
    }
    
    deinit {
        timer?.dispose()
    }
}

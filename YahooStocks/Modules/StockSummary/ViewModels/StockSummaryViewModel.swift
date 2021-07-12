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
        
    let allData = BehaviorRelay<[StockSummaryItem]>(value: [])
    let isGettingData = BehaviorRelay<Bool>(value: false)
    let presentErrorSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()
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
            guard let price = response.responseModel?.price else { return }
            var allData = [
                StockSummaryItem(title: "Symbol", value: price.symbol),
                StockSummaryItem(title: "Name", value: price.shortName),
                StockSummaryItem(title: "Price", value: price.regularMarketPrice.fmt),
                StockSummaryItem(title: "Open", value: price.regularMarketOpen.fmt),
                StockSummaryItem(title: "High", value: price.regularMarketDayHigh.fmt),
                StockSummaryItem(title: "Low", value: price.regularMarketDayLow.fmt)
            ]
            if price.regularMarketVolume.raw != 0 {
                allData.append(StockSummaryItem(title: "Volume", value: price.regularMarketVolume.fmt))
            }
            if price.marketCap.raw != 0 {
                allData.append(StockSummaryItem(title: "Market Cap", value: price.marketCap.fmt))
            }
            self?.allData.accept(allData)
        } onError: { [weak self] error in
            self?.presentErrorSubject.onNext(error.localizedDescription)
        } onCompleted: { [weak self] in
            self?.isGettingData.accept(false)
        }.disposed(by: disposeBag)
    }

}

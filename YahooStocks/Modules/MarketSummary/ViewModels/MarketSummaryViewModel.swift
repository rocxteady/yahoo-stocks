//
//  MarketSummaryViewModel.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelProtocol {
    
    associatedtype Model = Decodable
    
    var data: BehaviorRelay<[Model]> { get }
    var allData: BehaviorRelay<[Model]> { get }
    var searchTerm: String { get set }
    var disposeBag: DisposeBag { get }
    func getData(shouldRepeat: Bool)
    func search(searchTerm: String)
    
}

class MarketSummaryViewModel: ViewModelProtocol {
    
    let data = BehaviorRelay<[Market]>(value: [])
    let allData = BehaviorRelay<[Market]>(value: [])
    var searchTerm: String = ""
    let disposeBag = DisposeBag()
    
    func getData(shouldRepeat: Bool = true) {
        guard shouldRepeat else {
            getData()
            return
        }
        getData()
        Observable<Int>.interval(.seconds(8), scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.getData()
            }.disposed(by: disposeBag)
    }
    
    private func getData() {
        let api = MarketSummaryAPI()
        api.rx_start().subscribe { [weak self] response in
            self?.allData.accept(response.responseModel?.marketSummaryAndSparkResponse.result ?? [])
            self?.search(searchTerm: self?.searchTerm ?? "")
        } onError: { error in
            print(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func search(searchTerm: String = "") {
        self.searchTerm = searchTerm
        guard !searchTerm.isEmpty else {
            data.accept(allData.value)
            return
        }
        data.accept(allData.value.filter({ $0.name.contains(searchTerm) }))
    }
    
}

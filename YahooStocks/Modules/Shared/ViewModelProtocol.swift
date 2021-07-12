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
    
    var allData: BehaviorRelay<[Model]> { get }
    var isGettingData: BehaviorRelay<Bool> { get }
    var presentErrorSubject: PublishSubject<String> { get }
    var disposeBag: DisposeBag { get }
    var isDisplaying: Bool { get set }
    func getData()
    
}



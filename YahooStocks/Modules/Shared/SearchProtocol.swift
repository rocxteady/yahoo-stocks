//
//  SearchProtocol.swift
//  YahooStocks
//
//  Created by Ulas Sancak [Mirsisbilgiteknolojileri] on 12.07.2021.
//

import Foundation
import RxCocoa

protocol SearchProtocol: AnyObject {
    
    associatedtype Model = Decodable
    
    var filteredData: BehaviorRelay<[Model]> { get }
    var searchTerm: String { get set }
    func search(searchTerm: String)
    
}

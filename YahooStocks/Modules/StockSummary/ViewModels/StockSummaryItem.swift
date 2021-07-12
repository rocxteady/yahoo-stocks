//
//  StockSummaryItem.swift
//  YahooStocks
//
//  Created by Ulas Sancak [Mirsisbilgiteknolojileri] on 12.07.2021.
//

import Foundation

class StockSummaryItem: Decodable {
    
    let title: String
    let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
    
}

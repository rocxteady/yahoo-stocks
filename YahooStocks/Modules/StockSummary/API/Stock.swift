//
//  Stock.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation
import API

class StockSummaryRequestModel: BaseRequestModel {
    
    let symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
          case symbol
      }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.symbol, forKey: .symbol)
    }
    
}

class StockSummaryResponse: Decodable {
    
    let price: StockPrice
    
}

class StockPrice: Decodable {
    
    let regularMarketPrice: StockValue
    let regularMarketPreviousClose: StockValue
    let regularMarketOpen: StockValue
    let regularMarketDayHigh: StockValue
    let regularMarketDayLow: StockValue
    let regularMarketVolume: StockValue
    let marketCap: StockValue
    let shortName: String
    let symbol: String
    
}

//
//  Market.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation
import API

class MarketSummaryResponse: Decodable {
    
    let marketSummaryAndSparkResponse: BaseResponseModel<Market>
    
}

class Market: Decodable {
    
    let shortName: String?
    let regularMarketPreviousClose: StockValue
    let symbol: String
    
    var name: String {
        if let shortName = self.shortName {
            return shortName
        }
        return symbol
    }
    
    enum CodingKeys: String, CodingKey {
        case exchange
        case shortName
        case regularMarketPreviousClose
        case symbol
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        self.regularMarketPreviousClose = try container.decode(StockValue.self, forKey: .regularMarketPreviousClose)
    }
}

class StockValue: Decodable {
    
    let raw: Double
    let fmt: String
    
    enum CodingKeys: String, CodingKey {
        case raw
        case fmt
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.raw = try container.decodeIfPresent(Double.self, forKey: .raw) ?? 0
        self.fmt = try container.decodeIfPresent(String.self, forKey: .fmt) ?? ""
    }
    
}

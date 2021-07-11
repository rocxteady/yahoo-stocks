//
//  Market.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation
import API

class Market: Decodable {
    
    let exchange: String
    let shortName: String?
    let regularMarketPreviousClose: MarketClose
    
    var name: String {
        if let shortName = self.shortName {
            return shortName
        }
        return exchange
    }
    
    enum CodingKeys: String, CodingKey {
        case exchange
        case shortName
        case regularMarketPreviousClose
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.exchange = try container.decode(String.self, forKey: .exchange)
        self.shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        self.regularMarketPreviousClose = try container.decode(MarketClose.self, forKey: .regularMarketPreviousClose)
    }
}

class MarketClose: Decodable {
    
    let raw: Double
    let fmt: String
    
}

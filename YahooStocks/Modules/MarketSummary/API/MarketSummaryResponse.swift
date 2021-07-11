//
//  MarketSummaryResponse.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation
import API

class MarketSummaryResponse: Decodable {
    
    let marketSummaryAndSparkResponse: BaseResponseModel<Market>
    
}

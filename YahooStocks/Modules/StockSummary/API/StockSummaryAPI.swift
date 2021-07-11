//
//  StockSummaryAPI.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation
import API
import RestClient

class StockSummaryAPI: API {
    
    public typealias ResponseModel = StockSummaryResponse

    public typealias RequestModel = StockSummaryRequestModel
        
    public var uri = "/stock/v2/get-summary"
    
    public var endpoint: RestEndpoint
    
    public var parameters: RequestModel {
        didSet {
            endpoint.parameters = try? parameters.toDictionary()
        }
    }
    
    public init(parameters: RequestModel) {
        endpoint = RestEndpoint(urlString: Properties.baseURL + uri, parameters: try? parameters.toDictionary())
        self.parameters = parameters
    }
    
}

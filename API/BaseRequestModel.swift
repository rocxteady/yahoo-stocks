//
//  BaseRequestModel.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

open class BaseRequestModel: Encodable {
        
    var region = "US"
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case region = "region"
    }
}

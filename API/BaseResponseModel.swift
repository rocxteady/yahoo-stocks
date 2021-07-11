//
//  BaseResponseModel.swift
//  API
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation

open class BaseResponseModel<T: Decodable>: Decodable {
    
    public let result: [T]
    
}

//
//  Properties.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

public struct Properties {
    
    private(set) var apiKey: String?
    
    private(set) static var sharedProperties = Properties()
    public static let baseURL = "https://apidojo-yahoo-finance-v1.p.rapidapi.com"
    public static let headers: [String: String] = ["x-rapidapi-key": Properties.sharedProperties.apiKey ?? ""]
    
    public static func configure(apiKey: String) {
        Properties.sharedProperties.apiKey = apiKey
    }
    
}

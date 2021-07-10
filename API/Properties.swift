//
//  Properties.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

public struct Properties {
    public static let baseURL = "https://apidojo-yahoo-finance-v1.p.rapidapi.com"
    public static let apiKey = "2384700403msh44eea7176b21a86p1af5c9jsn7b9f5bf4e636"
    public static let headers: [String: String] = ["x-rapidapi-key":Properties.apiKey]
}

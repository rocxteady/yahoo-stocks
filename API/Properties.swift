//
//  Properties.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

public struct Properties {
    public static let baseURL = "https://apidojo-yahoo-finance-v1.p.rapidapi.com"
    public static let apiKey = "7a305d7a89mshe440385054337e0p1e31ffjsn26e2c6a0adec"
    public static let headers: [String: String] = ["x-rapidapi-key":Properties.apiKey]
}

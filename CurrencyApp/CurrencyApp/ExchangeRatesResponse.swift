//
//  ExchangeRatesResponse.swift
//  CurrencyApp
//
//  Created by Cleís Aurora Pereira on 13/11/20.
//

struct ExchangeRatesResponse: Decodable {
    let rates: [String: Double]
    let base: String
    let date: String
}

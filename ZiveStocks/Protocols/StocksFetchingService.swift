//
//  StocksAPI.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import Foundation

protocol StocksFetchingService {
    func fetchStocks(completion: @escaping (Result<Stocks, Error>) -> Void)
}

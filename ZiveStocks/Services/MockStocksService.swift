//
//  MockStocksService.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import Foundation

class MockStocksService: StocksFetchingService {
    func fetchStocks(completion: @escaping (Result<[Stock], Error>) -> Void) {
        // Create a mock stock data
        let mockData = [Stock(id: UUID(), symbol: "AAPL", companyName: "Apple Inc.", marketCap: 1000000000, sector: "Technology", industry: "Consumer Electronics", beta: 1.2, price: 150.00, lastAnnualDividend: 0.82, volume: 100000, exchange: "NASDAQ", exchangeShortName: "NAS", country: "USA", isEtf: false, isActivelyTrading: true)]
        
        // Call completion with .success
        completion(.success(mockData))
    }
}

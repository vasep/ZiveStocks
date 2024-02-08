//
//  StocksAPIClient.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import Foundation

class StocksAPIClient:StocksFetchingService {
    static let shared = StocksAPIClient()
        private init() {}

        func fetchStocks(completion: @escaping (Result<[Stock], Error>) -> Void) {
            guard let url = URL(string: Constants.stocksURL) else {
                completion(.failure(NSError(domain: "StocksAPIClient", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    completion(.failure(NSError(domain: "StocksAPIClient", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "StocksAPIClient", code: -3, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    let stocks = try JSONDecoder().decode([Stock].self, from: data)
                    completion(.success(stocks))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
}

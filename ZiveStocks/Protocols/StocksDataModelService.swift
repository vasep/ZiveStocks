//
//  StocksDataModelService.swift
//  ZiveStocks
//
//  Created by Vail Panov on 6.2.24.
//

import Foundation

protocol StocksDataModelService {
    func saveStock(stock: Stock)
    func deleteStock(stock: Stock)
    func getAllStocks()->[Stock]
}

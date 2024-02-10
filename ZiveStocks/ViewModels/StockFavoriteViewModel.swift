//
//  StockFavoriteViewModel.swift
//  ZiveStocks
//
//  Created by Zhivko Manchev on 10.2.24.
//

import Foundation

@Observable
class StockFavoriteViewModel: StocksDataModelService {
    var dataModelService: StocksDataModelService? {
        didSet {
            getAllStocks()
        }
    }
    var savedStocks = [Stock]()
    
    func isFavorite(_ stock: Stock) -> Bool {
        savedStocks.contains { $0.symbol == stock.symbol }
    }
    
    init() {
        
    }
    
    func saveStock(stock: Stock) {
        dataModelService?.saveStock(stock: stock)
        savedStocks.append(stock)
    }
    
    func deleteStock(stock: Stock) {
        if let index = savedStocks.firstIndex(where: { $0.symbol == stock.symbol }) {
            dataModelService?.deleteStock(stock: savedStocks[index])
            savedStocks.remove(at: index)
        }
    }
    
    func getAllStocks() -> [Stock] {
        savedStocks = dataModelService?.getAllStocks() ?? []
        return savedStocks
    }
    
    func toggleSave(stock: Stock) {
        if savedStocks.contains(where: { $0.symbol == stock.symbol }) {
            deleteStock(stock: stock)
        } else {
            saveStock(stock: stock)
        }
    }
}

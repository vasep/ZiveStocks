//
//  DataModelController.swift
//  ZiveStocks
//
//  Created by Vail Panov on 6.2.24.
//

import Foundation
import SwiftData

class DataModelController: StocksDataModelService{
    
    let modelContext : ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveStock(stock: Stock) {
        modelContext.insert(stock)
    }
    
    func deleteStock(stock: Stock) {
        
        modelContext.delete(stock)
    }
    
    func getAllStocks()->[Stock] {
        do {
            let descriptor = FetchDescriptor<Stock>(sortBy: [SortDescriptor(\.marketCap)])
            let stocks = try modelContext.fetch(descriptor)
            return stocks
        } catch {
            print("Fetch failed")
        }
        return []
    }
}

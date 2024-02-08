//
//  StockListViewModel.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import Foundation
import SwiftData

enum SortOption {
    case alphabetically, marketCap
}

@Observable
class StocksListViewModel: ObservableObject {
    
    var stocks: [Stock] = []
    var savedStocks: [Stock] = []
    var filteredStocks: [Stock] = []
    var errorMessage: String?
    var searchText = ""
    var uniqueCountryCodes: [String?] = []
    var selectedCountryCode: String? {
        didSet {
            filterStocks()
        }
    }
        
    private let service: StocksFetchingService?
    private let dataModelService : StocksDataModelService
    
    init(service: StocksFetchingService? = nil, stocksData:StocksDataModelService) {
        self.service = service
        self.dataModelService = stocksData
        fetchAllStocks()
    }
    
    func saveStock(stock: Stock) {
        dataModelService.saveStock(stock: stock)
        fetchAllStocks()
    }
    
    // Filter and Sort
    func sortStocks(by option: SortOption) {
          switch option {
          case .alphabetically:
              filteredStocks.sort { $0.symbol ?? "" < $1.symbol ?? "" }
          case .marketCap:
              filteredStocks.sort { $0.marketCap ?? 0 > $1.marketCap ?? 0 }
          }
      }
    
    func searchStocks() {
        filteredStocks = searchText.isEmpty ? stocks : stocks.filter { ($0.companyName ?? "").contains(searchText) }
      }
    
    func filterStocks() {
        filteredStocks = selectedCountryCode == nil ? stocks : stocks.filter { $0.country == selectedCountryCode }
    }

    
    func removeStock(stock: Stock) {
        if let index = savedStocks.firstIndex(where: { $0.symbol == stock.symbol }) {
            dataModelService.deleteStock(stock: savedStocks[index])
                 fetchAllStocks()
             }
    }
    
    func extractUniqueCountryCodes() {
        uniqueCountryCodes = Set(stocks.compactMap { $0.country }).sorted()
    }

    // Caching
    func fetchAllStocks() {
        savedStocks = dataModelService.getAllStocks()
    }
    
    func toggledSave(stock: Stock) {
        if savedStocks.contains(where: { $0.symbol == stock.symbol }) {
            removeStock(stock: stock)
        } else {
            saveStock(stock: stock)
        }
    }
    
    // Networking
    func loadStocks() {
        service?.fetchStocks { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stocksData):
                    self?.stocks = stocksData
                    self?.filteredStocks = self?.stocks ?? []
                    self?.extractUniqueCountryCodes()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

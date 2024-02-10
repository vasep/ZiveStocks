//
//  StockListViewModel.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import Foundation
import SwiftData
import Algorithms

enum SortOption {
    case alphabetically, marketCap
}

@Observable
class StocksListViewModel: ObservableObject {
    
    var allStocks: [Stock] = []
    var filteredStocks: [Stock] = []
    var errorMessage: String?
    var searchText = "" {
        didSet {
            searchStocks()
        }
    }
    var isLoading: Bool = false
    
    var uniqueCountryCodes: [String] = []
    var selectedCountryCode: String = ""
        
    private let service: StocksFetchingService?
    
    init(service: StocksFetchingService? = nil) {
        self.service = service
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
        filteredStocks = searchText.isEmpty ? allStocks : allStocks.filter { ($0.companyName ?? "").contains(searchText) }
      }
    
    func filterStocks() {
        filteredStocks = selectedCountryCode.isEmpty ? allStocks : allStocks.filter { $0.country == selectedCountryCode }
    }

    
    func extractUniqueCountryCodes() {
        uniqueCountryCodes = Array(allStocks.compactMap({ $0.country }).uniqued())
    }

    // Networking
    func fetchStocks() {
        isLoading = true
        service?.fetchStocks { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let stocksData):
                    self?.allStocks = stocksData
                    self?.filteredStocks = self?.allStocks ?? []
                    self?.extractUniqueCountryCodes()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

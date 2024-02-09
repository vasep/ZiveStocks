//
//  StocksListView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI
import SwiftData

struct StocksListView: View {
    
    @State var viewModel: StocksListViewModel
    
    init(service: StocksFetchingService, modelContext: StocksDataModelService) {
        self.viewModel = StocksListViewModel(service: service, stocksData: modelContext)
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(viewModel.filteredStocks) { stock in
                    NavigationLink(value: stock) {
                        StockRowView(stock: stock,isFavorite: viewModel.savedStocks.contains { $0.symbol == stock.symbol }, onFavoriteToggle: {
                            
                            viewModel.toggledSave(stock: stock)
                        })
                    }
                }
            }
            .navigationDestination(for: Stock.self) { stock in
                StockListItem(stock: stock)
            }
            .onAppear {
                viewModel.loadStocks()
                viewModel.fetchAllStocks()
            }
            .toolbar { toolbarContent() }
            .overlay(loadingOverlay)
        }
    }
    
    @ToolbarContentBuilder
       private func toolbarContent() -> some ToolbarContent {
           ToolbarItemGroup(placement: .navigationBarTrailing) {
               searchField
               filterMenu
               sortMenu
           }
       }

       private var searchField: some View {
           TextField("Search", text: $viewModel.searchText)
               .onChange(of: viewModel.searchText) { _, _ in
                   viewModel.searchStocks()
               }
               .textFieldStyle(.roundedBorder)
               .frame(width: 200)
       }

       private var filterMenu: some View {
           Menu {
               ForEach(viewModel.uniqueCountryCodes.compactMap { $0 }, id: \.self) { item in
                   Button(item) {
                       viewModel.selectedCountryCode = item
                   }
               }
               Button("Clear Filter") {
                   viewModel.selectedCountryCode = nil
               }
           } label: {
               Label("Filter", systemImage: "list.bullet")
           }
       }

       private var sortMenu: some View {
           Menu {
               Button("Alphabetically") {
                   viewModel.sortStocks(by: .alphabetically)
               }
               Button("By Market Cap") {
                   viewModel.sortStocks(by: .marketCap)
               }
           } label: {
               Label("Sort", systemImage: "arrow.up.arrow.down")
           }
       }
    
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if viewModel.allStocks.isEmpty {
            ContentUnavailableView(label: {
                Label("No Stocks", systemImage: "x.square")
            }, description: {
                Text("No available Data")
            }, actions: {})
            .offset(y: -60)
        }
    }

}

//#Preview {
//    StocksListView(service: MockStocksServices(), modelContext: DataMock())
//}

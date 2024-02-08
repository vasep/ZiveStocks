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
    @State var isShowingStockItem = false
    
    init(service: StocksFetchingService, modelContext: StocksDataModelService? = nil) {
        self.viewModel = StocksListViewModel(service: service, stocksData: modelContext!)
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(viewModel.filteredStocks) { stock in
                    StockRowView(stock: stock,isFavorite: viewModel.savedStocks.contains { $0.symbol == stock.symbol }, onFavoriteToggle: {
                        
                        viewModel.toggledSave(stock: stock)
                        
                    })
                }
                .onTapGesture {
                    isShowingStockItem = true
                }
            }
            .sheet(isPresented: $isShowingStockItem) {
                StockListItem()
            }
            .onAppear {
                viewModel.loadStocks()
                viewModel.fetchAllStocks()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // Search button
                    TextField("Search", text: $viewModel.searchText)
                    
                        .onChange(of: viewModel.searchText) { _, _ in
                            viewModel.searchStocks()
                        }
                    
                        .textFieldStyle(.roundedBorder)
                        .frame(width:200)
                    // Filter by country button with dropdown menu
                    Menu {
                        ForEach(viewModel.uniqueCountryCodes, id: \.self) { item in
                            Button(item ?? "") {
                                viewModel.selectedCountryCode = item
                            }
                        }
                        Button("Clear Filter") {
                                viewModel.selectedCountryCode = nil
                        }
                    } label: {
                        Label("Preview", systemImage: "list.bullet")
                    }
                    // Sort button with dropdown menu
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
            }
            .overlay {
                // Empty state View
                if viewModel.stocks.isEmpty {
                    ContentUnavailableView(label:{
                        Label("No Stocks",systemImage: "x.square")
                    },description:{
                        Text("No abailable Data")
                    } , actions: {})
                    .offset(y:-60)
                }
            }
        }
    }
}

#Preview {
    StocksListView(service: MockStocksService())
}

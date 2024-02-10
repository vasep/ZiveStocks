//
//  StocksListView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI
import SwiftData

struct StocksListView: View {
    @Environment(StockFavoriteViewModel.self) private var favoritesViewModel
    @State var viewModel: StocksListViewModel
    
    init(service: StocksFetchingService) {
        self.viewModel = StocksListViewModel(service: service)
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredStocks) { stock in
                NavigationLink(value: stock) {
                    StockRowView(stock: stock,isFavorite: favoritesViewModel.isFavorite(stock)) {
                        favoritesViewModel.toggleSave(stock: stock)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .toolbar)
            .navigationDestination(for: Stock.self) { stock in
                StockView(stock: stock)
            }
            .onAppear {
                viewModel.fetchStocks()
            }
            .toolbar { toolbarContent() }
            .overlay(loadingOverlay)
        }
    }
    
    @ToolbarContentBuilder
       private func toolbarContent() -> some ToolbarContent {
           ToolbarItemGroup(placement: .navigationBarTrailing) {
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
               Picker(selection: $viewModel.selectedCountryCode) {
                   ForEach(viewModel.uniqueCountryCodes, id: \.self) { item in
                       Text(item)
                           .tag(item)
                   }
                   
                   Text("All")
                       .tag("")
               } label: {
                   EmptyView()
               }
           } label: {
               Label("Filter", systemImage: "list.bullet")
           }
           .onChange(of: viewModel.selectedCountryCode) {
               viewModel.filterStocks()
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

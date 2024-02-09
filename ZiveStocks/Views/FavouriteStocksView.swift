//
//  FavouriteStocksView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI
import SwiftData

struct FavouriteStocksView: View {

    @State var viewModel: StocksListViewModel

    init(modelContext: StocksDataModelService) {
        viewModel = StocksListViewModel(stocksData: modelContext)
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(viewModel.savedStocks, id: \.self) { stock in
                    NavigationLink(stock.symbol ?? "", value: stock)
                }.onDelete(perform: { indexSet in
                    for index in indexSet {
                        viewModel.removeStock(stock: viewModel.savedStocks[index])
                    }
                })
             
            }
            .navigationDestination(for: Stock.self) { stock in
                StockListItem(stock: stock)
            }
            .navigationTitle("Favourite")
            .navigationBarTitleDisplayMode(.large)
            .onAppear{
                viewModel.fetchAllStocks()
            }
            .overlay (loadingOverlay)
        }
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.savedStocks.isEmpty {
            ContentUnavailableView(label:{
                Label("No Favourite Stocks",systemImage: "x.square")
            },description:{
            } , actions: {})
            .offset(y:-60)
        }
    }
}

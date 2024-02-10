//
//  FavouriteStocksView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI
import SwiftData

struct FavouriteStocksView: View {
    @Environment(StockFavoriteViewModel.self) private var viewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.savedStocks) { stock in
                    NavigationLink(value: stock) {
                        StockRowView(stock: stock)
                    }
                }
                .onDelete() { indexSet in
                    for index in indexSet {
                        viewModel.deleteStock(stock: viewModel.savedStocks[index])
                    }
                }
            }
            .navigationDestination(for: Stock.self) { stock in
                StockView(stock: stock)
            }
            .navigationTitle("Favourite")
            .navigationBarTitleDisplayMode(.large)
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

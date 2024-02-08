//
//  FavouriteStocksView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI
import SwiftData

struct FavouriteStocksView: View {
//    
//    @Environment(\.modelContext) var context
//    @Query var stocks: [Stock]
    @State var viewModel: StocksListViewModel

    init(modelContext: StocksDataModelService) {
        viewModel = StocksListViewModel(stocksData: modelContext)
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(viewModel.savedStocks, id: \.self) { stock in
                    Text("\(stock.symbol ?? "")")
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        viewModel.removeStock(stock: viewModel.savedStocks[index])
                    }
                })
            }
            
            .navigationTitle("Favourite")
            .navigationBarTitleDisplayMode(.large)
            .onAppear{
                viewModel.fetchAllStocks()
            }
            .overlay {
                if viewModel.savedStocks.isEmpty {
                    ContentUnavailableView(label:{
                        Label("No Favourite Stocks",systemImage: "x.square")
                    },description:{
                    } , actions: {})
                    .offset(y:-60)
                }
            }
        }
    }
}

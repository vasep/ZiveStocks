//
//  ContentView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context

    @State var favoritesViewModel = StockFavoriteViewModel()
    
    var body: some View {
        TabView {
            StocksListView(service: StocksAPIClient.shared)
                .tabItem {
                    Label("Stocks", systemImage: "list.bullet")
                }
            FavouriteStocksView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .environment(favoritesViewModel)
        .onAppear {
            if favoritesViewModel.dataModelService == nil {
                favoritesViewModel.dataModelService = DataModelController(modelContext: context)
            }
        }
    }
}

#Preview {
    ContentView()
}

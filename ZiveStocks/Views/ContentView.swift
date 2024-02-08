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

    var body: some View {
        TabView{
            StocksListView(service: StocksAPIClient.shared, modelContext: DataModelController(modelContext: context))
                .tabItem {
                    Label("Stocks", systemImage: "list.bullet")
                }
            FavouriteStocksView(modelContext: DataModelController(modelContext: context))
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}

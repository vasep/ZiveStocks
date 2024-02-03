//
//  ContentView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            StocksListView()
                .tabItem {
                    Label("Stocks", systemImage: "list.bullet")
                }
            FavouriteStocksView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}

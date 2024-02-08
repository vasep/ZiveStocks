//
//  ZiveStocksApp.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI
import SwiftData

@main
struct ZiveStocksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:[Stock.self])
    }
}

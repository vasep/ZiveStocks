//
//  SwiftUIView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 7.2.24.
//

import SwiftUI

struct StockView: View {
    
    var stock: Stock
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                       Text("Stock Details")
                           .font(.headline)
                           .padding(.bottom, 5)

                       Group {
                           Text("Symbol: \(stock.symbol ?? "N/A")")
                           Text("Company Name: \(stock.companyName ?? "N/A")")
                           Text("Market Cap: \(stock.marketCap?.formattedWithSuffix() ?? "")")
                           Text("Sector: \(stock.sector ?? "N/A")")
                           Text("Industry: \(stock.industry ?? "N/A")")
                           Text("Beta: \(stock.beta?.formattedWithSuffix() ?? "N/A")")
                           Text("Price: $\(stock.price?.formattedWithSuffix() ?? "N/A")")
                           Text("Last Annual Dividend: $\(stock.lastAnnualDividend?.formattedWithSuffix() ?? "N/A")")
                           Text("Volume: \(stock.volume ?? 0)")
                           Text("Exchange: \(stock.exchange ?? "N/A")")
                           Text("Exchange Short Name: \(stock.exchangeShortName ?? "N/A")")
                           Text("Country: \(stock.country ?? "N/A")")
                           Text("Is ETF: \(stock.isEtf?.description ?? "N/A")")
                           Text("Is Actively Trading: \(stock.isActivelyTrading?.description ?? "N/A")")
                       }
                       .font(.body)
                   }
                   .padding()
        }
    }
}

#Preview {
    let stock = Stock(id: UUID(), symbol: "AAPL", companyName: "Apple Inc.", marketCap: 1000000000, sector: "Technology", industry: "Consumer Electronics", beta: 1.2, price: 150.00, lastAnnualDividend: 0.82, volume: 100000, exchange: "NASDAQ", exchangeShortName: "NAS", country: "USA", isEtf: false, isActivelyTrading: true)
    
    return StockView(stock: stock)
}

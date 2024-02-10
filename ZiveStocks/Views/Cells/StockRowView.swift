//
//  StockRowView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI

struct StockRowView: View {
    
    let stock: Stock
    var isFavorite: Bool? = false
    var onFavoriteToggle: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            stockInfo
                .frame(maxWidth: .infinity, alignment: .leading)
//            Spacer()
            priceAndMarketCap
            if let isFavorite, let onFavoriteToggle {
                Button(action: onFavoriteToggle) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.leading, 8)
            }
        }
    }
    
    private var priceAndMarketCap: some View {
        VStack(alignment: .trailing) {
            Text("Price")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(stock.price.map { String(format: "$%.2f", $0) } ?? "N/A")
            
            Spacer()
            
            Text("Market Cap")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(stock.marketCap?.formattedWithSuffix() ?? "N/A")
        }
    }
    
    private var stockInfo: some View {
        VStack(alignment: .leading) {
            Text(stock.symbol ?? "N/A")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if let companyName = stock.companyName {
                Text(companyName)
                    .font(.subheadline)
            }
        }
    }
    
}

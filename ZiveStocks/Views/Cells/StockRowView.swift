//
//  StockRowView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 3.2.24.
//

import SwiftUI

struct StockRowView: View {
    
    let stock: Stock
    var isFavorite: Bool
    var onFavoriteToggle: () -> Void
    
    var body: some View {
        HStack {
            stockInfo
            Spacer()
            priceAndMarketCap
            favoriteButton
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
                ForEach(companyName.splitIntoLines(withWordLimit: 2), id: \.self) { line in
                    Text(line)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
        }
        .layoutPriority(1)
    }
    
    private var favoriteButton: some View {
        Button(action: onFavoriteToggle) {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundColor(isFavorite ? .yellow : .gray)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.leading, 8)
    }
}

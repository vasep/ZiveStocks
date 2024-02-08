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
            VStack(alignment: .leading) {
                Text(stock.symbol ?? "N/A").font(.subheadline).foregroundColor(.gray)
                ForEach((stock.companyName?.splitIntoLines(withWordLimit: 2))!, id: \.self) { line in
                            Text(line)
                                .font(.subheadline)
                                .lineLimit(1)
                        }
            }.layoutPriority(1)
            Spacer()
            VStack(alignment: .trailing) {
                Text("Price").font(.subheadline).foregroundColor(.gray)
                Text("$\(stock.price ?? 0.0, specifier: "%.2f")")
                Spacer()
                Text("Market Cap").font(.subheadline).foregroundColor(.gray)
                Text("$\(stock.marketCap?.formattedWithSuffix() ?? "N/A")")
            }
            Button(action: {
                self.onFavoriteToggle()
            }) {
                Image(systemName: "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.leading, 8)
        }
    }
}

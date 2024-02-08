//
//  SwiftUIView.swift
//  ZiveStocks
//
//  Created by Vail Panov on 7.2.24.
//

import SwiftUI

struct StockListItem: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("APPL")
                    .font(.headline)
                     .padding()
                
                Image(systemName: "exclamationmark.transmission")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
            }
        }
    }
}

#Preview {
    StockListItem()
}

//
//  Float+Extension.swift
//  ZiveStocks
//
//  Created by Vail Panov on 8.2.24.
//

import Foundation

extension Float {
    func formattedWithSuffix() -> String {
        let billion = Float(1_000_000_000)
        let million = Float(1_000_000)
        
        if self >= billion {
            return String(format: "%.2fB", self / billion)
        } else if self >= million {
            return String(format: "%.2fM", self / million)
        } else {
            return String(format: "%.2f", self)
        }
    }
}

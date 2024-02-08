//
//  Int+Extension.swift
//  ZiveStocks
//
//  Created by Vail Panov on 7.2.24.
//

import Foundation

extension Int {
    var formattedWithK: String {
        if self >= 1000 {
            let formattedNumber = Double(self) / 1000
            return String(format: "%.1fK", formattedNumber)
        } else {
            return "\(self)"
        }
    }
    
    func formattedWithSuffix() -> String {
         let billion = 1_000_000_000
         let million = 1_000_000
         
         if self >= billion {
             return String(format: "%.2fB", Float(self) / Float(billion))
         } else if self >= million {
             return String(format: "%.2fM", Float(self) / Float(million))
         } else {
             return "\(self)"
         }
     }
}

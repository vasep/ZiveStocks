//
//  String+Extension.swift
//  ZiveStocks
//
//  Created by Vail Panov on 7.2.24.
//

import Foundation

extension String {
    /// Splits the string into an array of strings, each containing up to `limit` words.
    func splitIntoLines(withWordLimit limit: Int) -> [String] {
        let words = self.split(separator: " ")
        var lines: [String] = []
        var currentLineWords: [String] = []

        for word in words {
            currentLineWords.append(String(word))
            if currentLineWords.count == limit {
                lines.append(currentLineWords.joined(separator: " "))
                currentLineWords.removeAll()
            }
        }

        // Add any remaining words as a line
        if !currentLineWords.isEmpty {
            lines.append(currentLineWords.joined(separator: " "))
        }

        return lines
    }
}

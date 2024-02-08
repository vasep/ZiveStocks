//
//  NewsServiceProtocol.swift
//  ZiveStocks
//
//  Created by Vail Panov on 7.2.24.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNews(completion: @escaping (Result<StockNews, Error>) -> Void)
}


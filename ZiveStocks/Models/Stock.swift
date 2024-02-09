
//
//  Created by Vail Panov on 3.2.24.
//

import Foundation
import SwiftData

@Model
class Stock : Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let symbol : String?
    let companyName : String?
    let marketCap : Int?
    let sector : String?
    let industry : String?
    let beta : Float?
    let price : Float?
    let lastAnnualDividend : Float?
    let volume : Int?
    let exchange : String?
    let exchangeShortName : String?
    let country : String?
    let isEtf : Bool?
    let isActivelyTrading : Bool?
    
    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case companyName = "companyName"
        case marketCap = "marketCap"
        case sector = "sector"
        case industry = "industry"
        case beta = "beta"
        case price = "price"
        case lastAnnualDividend = "lastAnnualDividend"
        case volume = "volume"
        case exchange = "exchange"
        case exchangeShortName = "exchangeShortName"
        case country = "country"
        case isEtf = "isEtf"
        case isActivelyTrading = "isActivelyTrading"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        marketCap = try values.decodeIfPresent(Int.self, forKey: .marketCap)
        sector = try values.decodeIfPresent(String.self, forKey: .sector)
        industry = try values.decodeIfPresent(String.self, forKey: .industry)
        beta = try values.decodeIfPresent(Float.self, forKey: .beta)
        price = try values.decodeIfPresent(Float.self, forKey: .price)
        lastAnnualDividend = try values.decodeIfPresent(Float.self, forKey: .lastAnnualDividend)
        volume = try values.decodeIfPresent(Int.self, forKey: .volume)
        exchange = try values.decodeIfPresent(String.self, forKey: .exchange)
        exchangeShortName = try values.decodeIfPresent(String.self, forKey: .exchangeShortName)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        isEtf = try values.decodeIfPresent(Bool.self, forKey: .isEtf)
        isActivelyTrading = try values.decodeIfPresent(Bool.self, forKey: .isActivelyTrading)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.symbol, forKey: .symbol)
        try container.encode(self.companyName, forKey: .companyName)
        try container.encode(self.marketCap, forKey: .marketCap)
        try container.encode(self.sector, forKey: .sector)
        try container.encode(self.industry, forKey: .industry)
        try container.encode(self.beta, forKey: .beta)
        try container.encode(self.price, forKey: .price)
        try container.encode(self.lastAnnualDividend, forKey: .lastAnnualDividend)
        try container.encode(self.volume, forKey: .volume)
        try container.encode(self.exchange, forKey: .exchange)
        try container.encode(self.exchangeShortName, forKey: .exchangeShortName)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.isEtf, forKey: .isEtf)
        try container.encode(self.isActivelyTrading, forKey: .isActivelyTrading)
    }
    
    init(id: UUID = UUID(), symbol: String? = nil, companyName: String, marketCap: Int, sector: String, industry: String, beta: Float, price: Float, lastAnnualDividend: Float, volume: Int, exchange: String, exchangeShortName: String, country: String, isEtf: Bool, isActivelyTrading: Bool) {
        self.id = id
        self.symbol = symbol
        self.companyName = companyName
        self.marketCap = marketCap
        self.sector = sector
        self.industry = industry
        self.beta = beta
        self.price = price
        self.lastAnnualDividend = lastAnnualDividend
        self.volume = volume
        self.exchange = exchange
        self.exchangeShortName = exchangeShortName
        self.country = country
        self.isEtf = isEtf
        self.isActivelyTrading = isActivelyTrading
    }
}


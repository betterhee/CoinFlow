//
//  ChartData.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/18.
//

import Foundation

struct ChartDataResponse: Codable {
    let chartDatas: [ChartData]
    
    enum CodingKeys: String, CodingKey {
        case chartDatas = "Data"
    }
}

struct ChartData: Codable {
    let time: TimeInterval
    let closePrice: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case closePrice = "close"
    }
}

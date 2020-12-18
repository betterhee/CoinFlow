//
//  CoinChartDataRequest.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/18.
//

import Foundation

struct CoinChartDataRequest: Request {
    var method: HTTPMethod = .get
    var params: RequestParam
    var path: String
    
    init(period: Period, param: RequestParam) {
        self.path = EndPoint.coinChartData + period.urlPath
        self.params = param
    }
}

//
//  CoinListRequest.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/18.
//

import Foundation

struct CoinListRequest: Request {
    var method: HTTPMethod = .get
    var params: RequestParam
    var path: String { return EndPoint.coinList + "pricemultifull" }
    
    init(param: RequestParam) {
        self.params = param
    }
}

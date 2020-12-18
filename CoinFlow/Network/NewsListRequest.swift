//
//  NewsListRequest.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/19.
//

import Foundation

struct NewsListRequest: Request {
    var method: HTTPMethod = .get
    var params: RequestParam
    var path: String { return EndPoint.newsList }
    
    init(param: RequestParam = .url([:])) {
        self.params = param
    }
}

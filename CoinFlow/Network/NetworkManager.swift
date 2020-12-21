//
//  NetworkManager.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/18.
//

import Foundation

class NetworkManager {
    static let session = URLSession.shared
}

extension NetworkManager {
    static func requestCoinList(completion: @escaping (Result<[Coin], Error>) -> Void) {
        let param: RequestParam = .url(["fsyms": "BTC,ETH,DASH,LTC,ETC,XRP,BCH,XMR,QTUM,ZEC,BTG",
                                        "tsyms": "USD"])
        guard let url = CoinListRequest(param: param).urlRequest().url else { return }
        let taskWithCoinListURL = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let responseData = data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(CoinListResponse.self, from: responseData)
                let coinList = response.raw.allCoins()
                completion(.success(coinList))
            } catch {
                completion(.failure(error))
            }
        }
        taskWithCoinListURL.resume()
    }
    
    static func requestCoinChartData(coinType: CoinType, period: Period, completion: @escaping (Result<[ChartData], Error>) -> Void) {
        let param: RequestParam = .url(["fsym": "\(coinType.rawValue)","tsym": "USD", "limit": "\(period.limitParameter)", "aggregate": "\(period.aggregateParameter)"])
        guard let url = CoinChartDataRequest(period: .day, param: param).urlRequest().url else { return }
        let taskWithCoinChartDataURL = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let responseData = data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ChartDataResponse.self, from: responseData)
                let chartDatas = response.chartDatas
                completion(.success(chartDatas))
            } catch {
                completion(.failure(error))
            }
        }
        taskWithCoinChartDataURL.resume()
    }
    
    static func requestNewsList(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = NewsListRequest().urlRequest().url else { return }
        let taskWithNewsURL = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let responseData = data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode([NewsResponse].self, from: responseData)
                let articles = response.flatMap { $0.articleArray }
                completion(.success(articles))
            } catch {
                completion(.failure(error))
            }
        }
        taskWithNewsURL.resume()
    }
}

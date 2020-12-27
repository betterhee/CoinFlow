//
//  ChartDetailViewModel.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/25.
//

import UIKit

class ChartDetailViewModel {
    typealias Handler = ([CoinChartInfo], Period) -> Void
    var changeHandler: Handler

    var coinInfo: CoinInfo!
    var chartDatas: [CoinChartInfo] = []
    var selectedPeriod: Period = .day

    init(coinInfo: CoinInfo, chartDatas: [CoinChartInfo], selectedPeriod: Period, changeHandler: @escaping Handler) {
        self.coinInfo = coinInfo
        self.chartDatas = chartDatas
        self.selectedPeriod = selectedPeriod
        self.changeHandler = changeHandler
    }
}

extension ChartDetailViewModel {
    func fetchData() {
        let dispatchGroup = DispatchGroup()

        Period.allCases.forEach { period in
            dispatchGroup.enter()
            NetworkManager.requestCoinChartData(coinType: coinInfo.key , period: period) { result in
                dispatchGroup.leave()
                switch result {
                case .success(let coinChartDatas):
                    self.chartDatas.append(CoinChartInfo(key: period, value: coinChartDatas))
                case .failure(let error):
                    print("--> error: \(error.localizedDescription)")
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.changeHandler(self.chartDatas, self.selectedPeriod)
        }
    }

    func updateNotify(handler: @escaping Handler) {
        self.changeHandler = handler
    }
}

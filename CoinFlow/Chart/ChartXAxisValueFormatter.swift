//
//  ChartXAxisValueFormatter.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/27.
//

import Foundation
import Charts

final class ChartXAxisDateFormatter: NSObject, IAxisValueFormatter {

    let period: Period

    init(period: Period) {
        self.period = period
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = period.dateFormat
        return formatter.string(from: Date(timeIntervalSince1970: value))
    }
}

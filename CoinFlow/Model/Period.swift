//
//  Period.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/18.
//

import Foundation

enum Period: String, CaseIterable {
    case day
    case week
    case month
    case year

    var dateFormat: String {
        switch self {
        case .day:
            return "H"
        case .week:
            return "d"
        case .month:
            return "d MMM"
        case .year:
            return "MMM"
        }
    }

    var urlPath: String {
        switch self {
        case .day, .week:
            return "histohour"
        default:
            return "histoday"
        }
    }

    var limitParameter: Int {
        switch self {
        case .day: // hour
            return 24
        case .week: // hour
            return 7 * 24 / 2
        case .month: // day
            return 30 / 1
        case .year: // day
            return 365 / 10
        }
    }

    var aggregateParameter: Int {
        switch self {
        case .day:
            return 1
        case .week:
            return 2
        case .month:
            return 1
        case .year:
            return 10
        }
    }
}


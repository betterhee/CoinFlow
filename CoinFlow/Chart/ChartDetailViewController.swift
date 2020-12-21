//
//  ChartDetailViewController.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/11/07.
//

import UIKit
import Charts

typealias CoinChartInfo = (key: Period, value: [ChartData])
class ChartDetailViewController: UIViewController {

    @IBOutlet weak var coinTypeLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var highlightBar: UIView!
    @IBOutlet weak var highlightBarLeading: NSLayoutConstraint!

    var coinInfo: CoinInfo!
    var chartDatas: [CoinChartInfo] = []
    var selectedPeriod: Period = .day

    override func viewDidLoad() {
        super.viewDidLoad()

        updateCoinInfo(coinInfo)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchData()
    }

    @IBAction func dailyButtonTapped(_ sender: UIButton) {
        renderChart(with: .day)
        moveHighlightBar(to: sender)
    }

    @IBAction func weeklyButtonTapped(_ sender: UIButton) {
        renderChart(with: .week)
        moveHighlightBar(to: sender)
    }

    @IBAction func monthlyButtonTapped(_ sender: UIButton) {
        renderChart(with: .month)
        moveHighlightBar(to: sender)
    }

    @IBAction func yealyButtonTapped(_ sender: UIButton) {
        renderChart(with: .year)
        moveHighlightBar(to: sender)
    }
}

extension ChartDetailViewController {
    private func fetchData() {
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
            self.renderChart(with: self.selectedPeriod)
        }
    }

    private func updateCoinInfo(_ coinInfo: CoinInfo) {
        coinTypeLabel.text = "\(coinInfo.key)"
        coinPriceLabel.text = String(format: "%.1f", coinInfo.value.usd.price)
    }

    private func moveHighlightBar(to button: UIButton) {
        highlightBarLeading.constant = button.frame.minX
    }

    private func renderChart(with period: Period) {

    }
}

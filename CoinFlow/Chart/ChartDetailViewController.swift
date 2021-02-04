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

    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var coinTypeLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var highlightBar: UIView!
    @IBOutlet weak var highlightBarLeading: NSLayoutConstraint!

    var viewModel: ChartDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateCoinInfo(viewModel)
        viewModel.updateNotify { chartDatas, selectedPeriod in
            self.renderChart(with: chartDatas, period: selectedPeriod)
        }
        viewModel.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func dailyButtonTapped(_ sender: UIButton) {
        viewModel.selectedPeriod = .day
        let datas = viewModel.chartDatas
        let selectedPeriod = viewModel.selectedPeriod
        renderChart(with: datas, period: selectedPeriod)
        moveHighlightBar(to: sender)
    }

    @IBAction func weeklyButtonTapped(_ sender: UIButton) {
        viewModel.selectedPeriod = .week
        let datas = viewModel.chartDatas
        let selectedPeriod = viewModel.selectedPeriod
        renderChart(with: datas, period: selectedPeriod)
        moveHighlightBar(to: sender)
    }

    @IBAction func monthlyButtonTapped(_ sender: UIButton) {
        viewModel.selectedPeriod = .month
        let datas = viewModel.chartDatas
        let selectedPeriod = viewModel.selectedPeriod
        renderChart(with: datas, period: selectedPeriod)
        moveHighlightBar(to: sender)
    }

    @IBAction func yealyButtonTapped(_ sender: UIButton) {
        viewModel.selectedPeriod = .year
        let datas = viewModel.chartDatas
        let selectedPeriod = viewModel.selectedPeriod
        renderChart(with: datas, period: selectedPeriod)
        moveHighlightBar(to: sender)
    }
}

extension ChartDetailViewController {
    private func updateCoinInfo(_ viewModel: ChartDetailViewModel) {
        coinTypeLabel.text = "\(viewModel.coinInfo.key)"
        coinPriceLabel.text = String(format: "%.1f", viewModel.coinInfo.value.usd.price)
    }

    private func moveHighlightBar(to button: UIButton) {
        highlightBarLeading.constant = button.frame.minX
    }

    private func renderChart(with chartDatas: [CoinChartInfo], period: Period) {
        guard let coinChartData = chartDatas.first(where:  { $0.key == period })?.value else { return }

        let chartDataEntry = coinChartData.map { chartData -> ChartDataEntry in
            let time = chartData.time
            let price = chartData.closePrice
            return ChartDataEntry(x: time, y: price)
        }

        let lineChartDataSet = LineChartDataSet(entries: chartDataEntry, label: "Coin Value")
        lineChartDataSet.mode = .horizontalBezier
        lineChartDataSet.colors = [UIColor.systemBlue]
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.drawCircleHoleEnabled = false
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.highlightEnabled = true
        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        lineChartDataSet.highlightColor = UIColor.systemBlue

        let data = LineChartData(dataSet: lineChartDataSet)
        chartView.data = data

        let startColor = UIColor.systemBlue
        let endColor = UIColor(white: 1, alpha: 0.3)

        let gradientColor = [startColor.cgColor, endColor.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColor, locations: colorLocations)
        lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        lineChartDataSet.drawFilledEnabled = true

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = ChartXAxisDateFormatter(period: period)
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = true
        xAxis.drawLabelsEnabled = true

        let leftYAxis = chartView.leftAxis
        leftYAxis.drawGridLinesEnabled = false
        leftYAxis.drawAxisLineEnabled = false
        leftYAxis.drawLabelsEnabled = false

        let rightYAxis = chartView.rightAxis
        rightYAxis.drawGridLinesEnabled = false
        rightYAxis.drawAxisLineEnabled = false
        rightYAxis.drawLabelsEnabled = false

        chartView.doubleTapToZoomEnabled = false
        chartView.dragEnabled = false

        chartView.delegate = self

        let description = Description()
        description.text = ""
        chartView.chartDescription = description

        let legend = chartView.legend
        legend.enabled = false
    }
}

extension ChartDetailViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        coinPriceLabel.text = String(format: "%.1f", entry.y)
    }
}

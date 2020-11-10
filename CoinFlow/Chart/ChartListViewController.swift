//
//  ChartListViewController.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/11/07.
//

import UIKit

class ChartListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Chart", bundle: .main)
        let chartDetailViewController = storyboard.instantiateViewController(identifier: "ChartDetailViewController")
        navigationController?.pushViewController(chartDetailViewController, animated: true)
    }
    
}

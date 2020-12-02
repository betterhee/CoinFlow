//
//  UIColor.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/11/14.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        let colors: [UIColor] = [.systemRed, .systemBlue, .systemPink, .systemTeal, .systemYellow, .systemGreen, .systemOrange]
        
        let randomColor = colors.randomElement()!
        return randomColor
    }
}

//
//  NewsListCell.swift
//  CoinFlow
//
//  Created by 홍다희 on 2020/12/22.
//

import UIKit
import Kingfisher

class NewsListCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!

    func configCell(article: Article) {
        let url = URL(string: article.imageURL)!
        thumbnail.kf.setImage(with: url)

        newsTitle.text = article.title

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        newsDate.text = formatter.string(from: Date(timeIntervalSince1970: article.timestamp))
    }
}

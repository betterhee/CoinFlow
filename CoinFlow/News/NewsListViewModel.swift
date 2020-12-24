//
//  NewsListViewModel.swift
//  Pods
//
//  Created by 홍다희 on 2020/12/24.
//

import UIKit

class NewsListViewModel {

    typealias Handler = ([Article]) -> Void
    var changeHandler: Handler
    var articles: [Article] = [] {
        didSet {
            changeHandler(articles)
        }
    }

    init(changeHandler: @escaping Handler) {
        self.changeHandler = changeHandler
    }
}

extension NewsListViewModel {
    func fetchData() {
        NetworkManager.requestNewsList { result in
            switch result {
            case .success(let articles):
                self.articles = articles
                print("--> articles \(articles)" )
            case .failure(let error):
                print("--> error: \(error.localizedDescription)")
            }
        }
    }

    var numberOfRowsInSection: Int {
        return articles.count
    }

    func cell(for indexPath: IndexPath, at tableView: UITableView) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as? NewsListCell else {
                return UITableViewCell()
            }
            let article = articles[indexPath.row]
            cell.configCell(article: article)
            return cell
    }

    func article(at indexPath: IndexPath) -> Article {
        let article = articles[indexPath.row]
        return article
    }
}

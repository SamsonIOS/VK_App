// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостями
final class NewsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let emptyText = ""
        static let headerCellID = "NewsHeaderCell"
        static let textCellID = "NewsTextCell"
        static let footerCellID = "NewsFooterCell"
    }

    private enum NewsCellType: Int, CaseIterable {
        case header
        case content
        case footer
    }

    // MARK: Private properties

    private let network = NetworkService()
    private var news: [NewsFeed] = []

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
    }

    // MARK: Private Methods

    private func fetchNews() {
        network.fetchNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.filterNews(response: response)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func filterNews(response: NewsFeedResponse) {
        response.news.forEach { item in
            if item.sourceID < 0 {
                guard let group = response.groups.filter({ group in
                    group.id == item.sourceID * -1
                }).first else { return }
                item.authorName = group.name
                item.avatarPath = group.photoPath

            } else {
                guard let user = response.friends.filter({ user in
                    user.id == item.sourceID
                }).first else { return }
                item.authorName = "\(user.firstName) \(user.lastName)"
                item.avatarPath = user.userImagePath
            }
        }
        DispatchQueue.main.async {
            self.news = response.news
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource

extension NewsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsCellType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.section]
        let cellType = NewsCellType(rawValue: indexPath.row) ?? .content
        var cellID = Constants.emptyText

        switch cellType {
        case .header:
            cellID = Constants.headerCellID
        case .content:
            cellID = Constants.textCellID
        case .footer:
            cellID = Constants.footerCellID
        }
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NewsCell
        else { return UITableViewCell() }
        cell.configure(news: item, network: network)
        return cell
    }
}

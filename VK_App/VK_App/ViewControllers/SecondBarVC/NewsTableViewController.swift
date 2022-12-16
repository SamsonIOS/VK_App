// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостями
final class NewsTableViewController: UITableViewController, NewsPostCellDelegate {
    // MARK: Constants

    private enum Constants {
        static let emptyText = ""
        static let headerCellID = "NewsHeaderCell"
        static let textCellID = "NewsTextCell"
        static let footerCellID = "NewsFooterCell"
        static let imageCellID = "NewsImageCell"
        static let refreshingText = "Refreshing..."
    }

    private enum NewsCellType: Int, CaseIterable {
        case header
        case text
        case image
        case footer
    }

    // MARK: Private properties

    private let networkService = NetworkNewsService()
    private var isLoading = false
    private var nextFrom = Constants.emptyText
    private var news: [NewsFeed] = []
    private var mostFreshDate: Double?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }

    // MARK: Public Methods

    func didTappedShowMore(_ cell: NewsTextCell) {
        tableView.beginUpdates()
        cell.isExpanded.toggle()
        tableView.endUpdates()
    }

    // MARK: Private Methods

    @objc private func refreshNewsAction() {
        refreshControl?.beginRefreshing()
        fetchNews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl?.endRefreshing()
        }
    }

    private func setViewController() {
        tableView.prefetchDataSource = self
        setupRefreshControl()
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: Constants.refreshingText)
        refreshControl?.tintColor = .black
        refreshControl?.addTarget(self, action: #selector(refreshNewsAction), for: .valueChanged)
    }

    private func fetchNews() {
        if let firstItem = news.first {
            mostFreshDate = firstItem.date + 1
        }
        networkService.fetchNews(startTime: mostFreshDate, nextFrom: nextFrom) { [weak self] result in
            switch result {
            case let .success(response):
                guard let self = self else { return }
                self.filterNews(response: response)
                self.nextFrom = nextFrom
                self.news = response.news + self.news
                self.tableView.reloadData()
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
                    user.id == item.sourceID * 1
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

    private func fetchNews(nextFrom: String) {
        networkService.fetchNews(nextFrom: nextFrom) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                let indexSet = IndexSet(integersIn: self.news.count ..< self.news.count + response.news.count)
                self.news.append(contentsOf: self.news)
                self.tableView.insertSections(indexSet, with: .automatic)
                self.isLoading = false
            case let .failure(error):
                print(error.localizedDescription)
            }
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
        let news = news[indexPath.section]
        let cellType = NewsCellType(rawValue: indexPath.row) ?? .text
        var cellID = Constants.emptyText

        switch cellType {
        case .header:
            cellID = Constants.headerCellID
        case .text:
            cellID = Constants.textCellID
        case .image:
            cellID = Constants.imageCellID
        case .footer:
            cellID = Constants.footerCellID
        }
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NewsCell
        else { return UITableViewCell() }
        cell.configure(news: news)
        if let textCell = cell as? NewsTextCell {
            textCell.delegate = self
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            guard let item = news[indexPath.section].text,
                  !item.isEmpty
            else { return 0.0 }
        case 2:
            guard
                let item = news[indexPath.section].attachments?.first?.photo?.photos.last?.aspectRatio
            else { return CGFloat() }
            let tableWidth = tableView.bounds.width
            let cellHeigt = tableWidth * item
            return cellHeigt
        default:
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
}

// MARK: UITableViewDataSourcePrefetching

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxSection = indexPaths.map(\.section).max()
                maxSection > news.count - 3,
            !isLoading
        else {
            isLoading = true
            fetchNewsWithInfinityScroll()
        }
    }
}


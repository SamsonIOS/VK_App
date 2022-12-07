// NewsHeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка хедера
final class NewsHeaderCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOtlets

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var datePostLabel: UILabel!

    // MARK: Public Methodds

    func configure(news: NewsFeed, network: NetworkService) {
        datePostLabel.text = convertDate(dateValue: news.date)
        userNameLabel.text = news.authorName
        guard let avatarPost = news.avatarPath else { return }
        userImageView.loadDatas(url: avatarPost, networkService: network)
    }

    // MARK: Private Methods

    private func convertDate(dateValue: Int) -> String {
        let truncatedTime = TimeInterval(dateValue)
        let date = Date(timeIntervalSince1970: truncatedTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.string(from: date)
    }
}

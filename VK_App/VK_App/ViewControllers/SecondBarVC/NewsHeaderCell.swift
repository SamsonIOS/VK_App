// NewsHeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка хедера
final class NewsHeaderCell: UITableViewCell, NewsConfigurable {
    // MARK: Constants

    private enum Constants {
        static let dateStyle = "MM-dd-yyyy HH:mm"
    }

    // MARK: Private IBOtlets

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var datePostLabel: UILabel!

    // MARK: Public Methodds

    func configure(news: NewsFeed) {
        datePostLabel.text = convert(dateValue: news.date)
        userNameLabel.text = news.authorName
        guard let url = URL(string: news.avatarPath ?? "") else { return }
        userImageView.load(url: url)
    }

    // MARK: Private Methods

    private func convert(dateValue: Int) -> String {
        let truncatedTime = TimeInterval(dateValue)
        let date = Date(timeIntervalSince1970: truncatedTime)
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateStyle
        return formatter.string(from: date)
    }
}

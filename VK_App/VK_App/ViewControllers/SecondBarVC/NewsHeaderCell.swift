// NewsHeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка хедера
final class NewsHeaderCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var datePostLabel: UILabel!

    // MARK: Public Methods

    func configure(news: NewsFeed) {
        datePostLabel.text = DateFormatter.convert(dateValue: news.date)
        userNameLabel.text = news.authorName
        guard let url = URL(string: news.avatarPath ?? "") else { return }
        userImageView.load(url: url)
    }

    func configure(news: NewsFeed, photoService: PhotoService?, indexPath: Int?) {
        datePostLabel.text = DateFormatter.convert(dateValue: news.date)
        userNameLabel.text = news.authorName
        guard let photo = news.avatarPath else { return }
        let atIndexPath = IndexPath(index: indexPath ?? 0)
        userImageView.image = photoService?.photo(atIndexpath: atIndexPath, byUrl: photo)
    }
}

// NewsTextCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка текста поста
final class NewsTextCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet var overviewPostLabels: UITextView!

    // MARK: Public Methods

    func configure(news: NewsFeed, network: NetworkService) {
        overviewPostLabels.text = news.text
    }
}

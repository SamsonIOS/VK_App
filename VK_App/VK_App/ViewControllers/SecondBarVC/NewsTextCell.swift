// NewsTextCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка текста поста
final class NewsTextCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet private var overviewPostLabels: UITextView!

    // MARK: Public Methods

    func configure(news: NewsFeed) {
        overviewPostLabels.text = news.text
    }
}

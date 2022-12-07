// NewsImageCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фото поста
final class NewsImageCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet private var postImageView: UIImageView!

    // MARK: Public Methods

    func configure(news: NewsFeed) {
        guard let photo = news.copyHistory?.first?.attachments?.first?.photo?.photos.first?.url,
              let url = URL(string: photo) else { return }
        postImageView.load(url: url)
    }
}

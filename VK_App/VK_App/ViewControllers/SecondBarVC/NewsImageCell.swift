// NewsImageCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фото поста
final class NewsImageCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet private var postImageView: UIImageView!

    // MARK: Public Methods

    func configure(news: NewsFeed, network: NetworkService) {
        guard let photo = news.copyHistory?.last?.attachments?.last?.photo?.photos.first.map(\.url) else { return }
        postImageView.loadDatas(url: photo, networkService: network)
    }
}

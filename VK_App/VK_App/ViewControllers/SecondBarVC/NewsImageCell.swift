// NewsImageCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фото поста
final class NewsImageCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet private var postImageView: UIImageView!

    // MARK: Public Methods

    func configure(news: NewsFeed, photoService: PhotoService?, indexPath: Int?) {
        guard let photo = news.attachments?.first?.photo?.photos.last?.url else { return }
        let atIndexPath = IndexPath(index: indexPath ?? 0)
        postImageView.image = photoService?.photo(atIndexpath: atIndexPath, byUrl: photo)
    }
}

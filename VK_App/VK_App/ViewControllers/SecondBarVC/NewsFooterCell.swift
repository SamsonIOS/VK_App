// NewsFooterCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка футера
final class NewsFooterCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet private var likeControl: LikeControl!
    @IBOutlet private var commentLabel: UILabel!
    @IBOutlet private var repostLabel: UILabel!
    @IBOutlet private var viewLabel: UILabel!

    // MARK: Public Methods

    func configure(news: NewsFeed) {
        likeControl.likesLabel.text = String(news.likes.count)
        commentLabel.text = String(news.comments.count)
        repostLabel.text = String(news.reposts.count)
        viewLabel.text = String(news.views.count)
    }
}

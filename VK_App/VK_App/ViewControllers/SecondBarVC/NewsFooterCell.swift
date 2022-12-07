// NewsFooterCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка футера
final class NewsFooterCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet private var likesControl: LikeControl!
    @IBOutlet private var commentsLabel: UILabel!
    @IBOutlet private var repostsLabel: UILabel!
    @IBOutlet private var viewsLabel: UILabel!

    // MARK: Public Methods

    func configure(news: NewsFeed, network: NetworkService) {
        likesControl.likesLabel.text = String(news.likes.count)
        commentsLabel.text = String(news.comments.count)
        repostsLabel.text = String(news.reposts.count)
        viewsLabel.text = String(news.views.count)
    }
}

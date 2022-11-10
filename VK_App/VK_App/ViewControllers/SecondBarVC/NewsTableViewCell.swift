// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка поста
final class NewsTableViewCell: UITableViewCell {
    // MARK: IBOutlets

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var overviewPostLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var likesCountView: LikeControl!

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setLikesView()
    }

    // MARK: Public Methods

    func setCellInfo(_ news: News) {
        userImageView.image = UIImage(named: news.userImageName)
        userNameLabel.text = news.userName
        overviewPostLabel.text = news.overviewPost
        postImageView.image = UIImage(named: news.postImageName)
    }

    // MARK: Private Methods

    private func setLikesView() {
        likesCountView.layer.cornerRadius = 12
        likesCountView.clipsToBounds = true
        likesCountView.backgroundColor = .none
    }
}

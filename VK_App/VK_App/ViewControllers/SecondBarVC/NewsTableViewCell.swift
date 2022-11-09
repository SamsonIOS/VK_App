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
    @IBOutlet private var likesCount: LikeControl!

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setLikesView()
    }

    // MARK: Public Methods

    func setCellInfo(_ model: News) {
        userImageView.image = UIImage(named: model.userImageName)
        userNameLabel.text = model.userName
        overviewPostLabel.text = model.overviewPost
        postImageView.image = UIImage(named: model.postImageName)
    }

    // MARK: Private Methods

    private func setLikesView() {
        likesCount.layer.cornerRadius = 12
        likesCount.clipsToBounds = true
        likesCount.backgroundColor = .none
    }
}

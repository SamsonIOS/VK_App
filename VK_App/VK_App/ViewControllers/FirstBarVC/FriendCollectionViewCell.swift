// FriendCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с именем друга и его фото
final class FriendCollectionViewCell: UICollectionViewCell {
    // MARK: IBOutlet

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var likesView: LikeControl!

    // MARK: Public Methods

    func friendInfo(_ model: User) {
        nameLabel.text = model.friendName
        friendImageView.image = UIImage(named: model.friendImage)

        likesView.layer.cornerRadius = 12
        likesView.clipsToBounds = true
        likesView.backgroundColor = .blue
    }
}

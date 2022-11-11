// FriendCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с именем друга и его фото
final class FriendCollectionViewCell: UICollectionViewCell {
    // MARK: IBOutlet

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var likesView: LikeControl!

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setLikesView()
    }

    // MARK: Public Methods

    func friendInfo(nameUser: String, nameImage: String) {
        nameLabel.text = nameUser
        friendImageView.image = UIImage(named: nameImage)
        friendImageView.setupTapGestureRecognizer()
        friendImageView.animationDidTapAction()
        friendImageView.layer.borderColor = UIColor.blue.cgColor
        friendImageView.layer.borderWidth = 1
    }

    // MARK: Private Methods

    private func setLikesView() {
        likesView.layer.cornerRadius = 12
        likesView.clipsToBounds = true
        likesView.backgroundColor = .blue
    }
}

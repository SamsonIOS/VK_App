// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для друзей
final class FriendTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var friendName: UILabel!
    @IBOutlet private var shadowForPersonView: FriendsView!

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        shadowForPersonView.setImageView()
        shadowForPersonView.imageDidTapAction()
    }

    // MARK: Public Methods

    func addFriends(nameUser: String, nameImage: String) {
        friendName.text = nameUser
        shadowForPersonView.setImage(imageName: nameImage)
    }
}

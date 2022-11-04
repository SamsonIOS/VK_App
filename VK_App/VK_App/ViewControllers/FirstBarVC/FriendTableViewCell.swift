// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для друзей
final class FriendTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var friendName: UILabel!
    @IBOutlet private var shadowForPersonView: FriendsView!

    // MARK: Public Methods

    func addFriends(_ model: User) {
        friendName.text = model.friendName
        shadowForPersonView.setImage(imageName: model.friendImage)
    }
}

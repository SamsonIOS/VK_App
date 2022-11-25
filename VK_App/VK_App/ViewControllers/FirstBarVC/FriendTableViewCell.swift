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
        shadowForPersonView.setupTapGestureRecognizer()
        shadowForPersonView.animationDidTapAction()
    }

    // MARK: Public Methods

    func addFriends(user: User) {
        friendName.text = user.firstName
        shadowForPersonView.setImage(imageName: user.avatarImagePath)
    }
}

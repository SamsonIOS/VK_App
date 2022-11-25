// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для друзей
final class FriendTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var friendName: UILabel!
    @IBOutlet private var shadowForPersonView: FriendsView!

    // MARK: Private properties

    private var currentPath = ""

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        shadowForPersonView.setupTapGestureRecognizer()
        shadowForPersonView.animationDidTapAction()
    }

    // MARK: Public Methods

    func addFriends(user: User) {
        shadowForPersonView.image = nil
        friendName.text = "\(user.firstName) \(user.lastName)"
        getImage(imagePath: user.userImagePath)
        currentPath = user.userImagePath
    }

    // MARK: Private Methods

    private func getImage(imagePath: String) {
        LoadingImage.shared.getImage(imagePosterPath: imagePath) { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if imagePath == self.currentPath {
                    self.shadowForPersonView.image = UIImage(data: data)
                }
            }
        }
    }
}

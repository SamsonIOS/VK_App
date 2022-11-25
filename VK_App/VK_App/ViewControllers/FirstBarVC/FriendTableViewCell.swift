// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для друзей
final class FriendTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var friendName: UILabel!
    @IBOutlet private var shadowForPersonView: FriendsView!

    private let imageLoader = ImageLoader.shared
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
        getImage(for: user.userImagePath)
        currentPath = user.userImagePath
    }

    private func getImage(for path: String) {
        ImageLoader.shared.getImage(imagePosterPath: path) { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if path == self.currentPath {
                    self.shadowForPersonView.image = UIImage(data: data)
                }
            }
        }
    }
}

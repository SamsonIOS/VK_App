// FriendCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер с показом информации о друге
final class FriendCollectionViewController: UICollectionViewController {
    // MARK: Constants

    private enum Constants {
        static let collectionFriendsCellId = "collectionFriendsCell"
    }

    // MARK: Private properties

    var collectionFriendList: User?
}

// MARK: UICollectionViewDataSource

extension FriendCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.collectionFriendsCellId,
            for: indexPath
        ) as? FriendCollectionViewCell else { return UICollectionViewCell() }

        guard let friend = collectionFriendList else { return UICollectionViewCell() }
        cell.friendInfo(friend)
        return cell
    }
}

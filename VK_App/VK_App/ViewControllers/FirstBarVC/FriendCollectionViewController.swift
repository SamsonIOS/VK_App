// FriendCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер с показом информации о друге
final class FriendCollectionViewController: UICollectionViewController {
    // MARK: Constants

    private enum Constants {
        static let collectionFriendsCellId = "collectionFriendsCell"
    }

    // MARK: Public properties

    var collectionFriendList: (String, String)?
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
        ) as? FriendCollectionViewCell,
            let friend = collectionFriendList
        else {
            return UICollectionViewCell()
        }
        cell.friendInfo(nameUser: friend.0, nameImage: friend.1)
        return cell
    }
}

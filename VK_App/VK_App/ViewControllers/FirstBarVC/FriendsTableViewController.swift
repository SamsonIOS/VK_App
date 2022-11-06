// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// контролер со списком друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let firstName = "Gomer"
        static let firstImageName = "gomer"
        static let secondName = "Mr.Garry"
        static let secondImageName = "garrys"
        static let thirdName = "BART"
        static let thirdImageName = "bart"
        static let fourthName = "OldDedulya"
        static let fourthImageName = "ded2"
        static let fiveName = "Young Gomer"
        static let fiveImageName = "buh"
        static let sixName = "Calmar"
        static let sixImageName = "shupalz"
        static let sevenName = "Liza Simpson"
        static let sevenImageName = "malaya2"
        static let friendsCellId = "friendsCell"
        static let storyName = "Main"
        static let storyId = "second"
    }

    // MARK: Private properties

    private var friendsList = [
        User(friendName: Constants.firstName, friendImage: Constants.firstImageName),
        User(friendName: Constants.secondName, friendImage: Constants.secondImageName),
        User(friendName: Constants.thirdName, friendImage: Constants.thirdImageName),
        User(friendName: Constants.fourthName, friendImage: Constants.fourthImageName),
        User(friendName: Constants.fiveName, friendImage: Constants.fiveImageName),
        User(friendName: Constants.sixName, friendImage: Constants.sixImageName),
        User(friendName: Constants.sevenName, friendImage: Constants.sevenImageName),
    ]
}

// MARK: UITableViewDataSource

extension FriendsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellId,
            for: indexPath
        ) as? FriendTableViewCell
        else { return UITableViewCell() }

        cell.addFriends(friendsList[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: Constants.storyName, bundle: nil)
        guard let secondVC = story
            .instantiateViewController(withIdentifier: Constants.storyId) as? FriendCollectionViewController
        else { return }
        let list = friendsList[indexPath.row]
        secondVC.collectionFriendList = list
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

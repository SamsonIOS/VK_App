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

    // MARK: IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: Private properties

    private var sections: [Character: [(String, String)]] = [:]
    private var sectionsTitle: [Character] = .init()
    private var friendsList = [
        User(friendName: Constants.firstName, friendImage: Constants.firstImageName),
        User(friendName: Constants.secondName, friendImage: Constants.secondImageName),
        User(friendName: Constants.thirdName, friendImage: Constants.thirdImageName),
        User(friendName: Constants.fourthName, friendImage: Constants.fourthImageName),
        User(friendName: Constants.fiveName, friendImage: Constants.fiveImageName),
        User(friendName: Constants.sixName, friendImage: Constants.sixImageName),
        User(friendName: Constants.sevenName, friendImage: Constants.sevenImageName),
    ]

    private var filteredFriendsList: [Character: [(String, String)]] = [:]

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        sortedMethod()
    }

    // MARK: Private Methods

    private func sortedMethod() {
        for users in friendsList {
            guard let firstChar = users.friendName.first
            else { return }

            if sections[firstChar] != nil {
                sections[firstChar]?.append((users.friendName, users.friendImage))
            } else {
                sections[firstChar] = [(users.friendName, users.friendImage)]
            }
        }
        sectionsTitle = Array(sections.keys)
        sectionsTitle.sort()
        filteredFriendsList = sections
    }
}

// MARK: UITableViewDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        filteredFriendsList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredFriendsList[sectionsTitle[section]]?.count ?? 0
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionsTitle.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionsTitle[section])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellId,
            for: indexPath
        ) as? FriendTableViewCell,
            let infoForCell = filteredFriendsList[sectionsTitle[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.addFriends(nameUser: infoForCell.0, nameImage: infoForCell.1)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: Constants.storyName, bundle: nil)
        guard let secondVC = story
            .instantiateViewController(withIdentifier: Constants.storyId) as? FriendCollectionViewController
        else { return }
        let list = filteredFriendsList[sectionsTitle[indexPath.section]]?[indexPath.row]
        secondVC.collectionFriendList = list
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

// MARK: UISearchBarDelegate

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriendsList = [:]

        if searchText.isEmpty {
            filteredFriendsList = sections
            sectionsTitle = Array(filteredFriendsList.keys)
            sectionsTitle.sort()
        } else {
            for friends in sections {
                guard let new = friends.value.first else { return }
                let firstChar = friends.key
                if new.0.lowercased().contains(searchText.lowercased()) {
                    if filteredFriendsList[firstChar] != nil {
                        filteredFriendsList[firstChar]?.append((new.0, new.1))
                    } else {
                        filteredFriendsList[firstChar] = [(new.0, new.1)]
                    }
                }
                sectionsTitle = Array(filteredFriendsList.keys)
                sectionsTitle.sort()
            }
        }
        tableView.reloadData()
    }
}

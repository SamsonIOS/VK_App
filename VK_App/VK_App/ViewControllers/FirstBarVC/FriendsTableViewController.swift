// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// контролер со списком друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let firstName = "Gomer"
        static let firstImageName = "gomer"
        static let firstGomerImageName = "gomer3"
        static let secondGomerImageName = "gomer4"
        static let thirdGomerImageName = "gomer5"
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
        static let firstLizaImageName = "liza2"
        static let secondLizaImageName = "liza3"
        static let thirdLizaImageName = "liza4"
        static let friendsCellId = "friendsCell"
        static let storyName = "Main"
        static let storyID = "second"
        static let storyFriendPhotoID = "friendsVC"
        static let searchGroupName = "VK"
    }

    // MARK: IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: Private properties

    private var sectionsMap: [Character: [(String, String, [String]?)]] = [:]
    private var sectionTitles: [Character] = .init()
    private var friends = [
        User(
            friendName: Constants.firstName,
            friendImage: Constants.firstImageName,
            userPhotoNames: [
                Constants.firstGomerImageName,
                Constants.secondGomerImageName,
                Constants.thirdGomerImageName
            ]
        ),
        User(
            friendName: Constants.secondName,
            friendImage: Constants.secondImageName
        ),
        User(
            friendName: Constants.thirdName,
            friendImage: Constants.thirdImageName
        ),
        User(friendName: Constants.fourthName, friendImage: Constants.fourthImageName),
        User(friendName: Constants.fiveName, friendImage: Constants.fiveImageName),
        User(friendName: Constants.sixName, friendImage: Constants.sixImageName),
        User(
            friendName: Constants.sevenName,
            friendImage: Constants.sevenImageName,
            userPhotoNames: [Constants.firstLizaImageName, Constants.secondLizaImageName, Constants.thirdLizaImageName]
        ),
    ]

    private var filteredFriendsMap: [Character: [(String, String, [String]?)]] = [:]

    private let networkAPIService = NetworkAPIService()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarDelegate()
        sortedMethod()
        infoAboutUser()
    }

    // MARK: Private Methods

    private func infoAboutUser() {
        networkAPIService.fetchFriends()
        networkAPIService.fetchUserPhotos()
        networkAPIService.fetchGroups()
        networkAPIService.fetchSearchedGroup(group: Constants.searchGroupName)
    }

    private func searchBarDelegate() {
        searchBar.delegate = self
    }

    private func sortedMethod() {
        for users in friends {
            guard let firstChar = users.friendName.first
            else { return }

            if sectionsMap[firstChar] != nil {
                sectionsMap[firstChar]?.append((users.friendName, users.friendImage, users.userPhotoNames))
            } else {
                sectionsMap[firstChar] = [(users.friendName, users.friendImage, users.userPhotoNames)]
            }
        }
        sectionTitles = Array(sectionsMap.keys)
        sectionTitles.sort()
        filteredFriendsMap = sectionsMap
    }

    private func setDidSelectRow(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.storyName, bundle: nil)
        guard let friendsPhotosViewController = storyboard
            .instantiateViewController(withIdentifier: Constants.storyFriendPhotoID) as? FriendsPhotosViewController
        else { return }
        guard let list = filteredFriendsMap[sectionTitles[indexPath.section]]?[indexPath.row] else { return }
        friendsPhotosViewController.configure(nameFriend: list.0, allPhotoFriend: list.2)
        navigationController?.pushViewController(friendsPhotosViewController, animated: true)
    }
}

// MARK: UITableViewDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        filteredFriendsMap.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredFriendsMap[sectionTitles[section]]?.count ?? 0
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionTitles[section])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellId,
            for: indexPath
        ) as? FriendTableViewCell,
            let infoForCell = filteredFriendsMap[sectionTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.addFriends(nameUser: infoForCell.0, nameImage: infoForCell.1)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setDidSelectRow(indexPath: indexPath)
    }
}

// MARK: UISearchBarDelegate

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriendsMap = [:]

        if searchText.isEmpty {
            filteredFriendsMap = sectionsMap
        } else {
            for friends in sectionsMap {
                guard let new = friends.value.first else { return }
                let firstChar = friends.key
                if new.0.lowercased().contains(searchText.lowercased()) {
                    if filteredFriendsMap[firstChar] != nil {
                        filteredFriendsMap[firstChar]?.append((new.0, new.1, new.2))
                    } else {
                        filteredFriendsMap[firstChar] = [(new.0, new.1, new.2)]
                    }
                }
            }
        }
        sectionTitles = Array(filteredFriendsMap.keys)
        sectionTitles.sort()
        tableView.reloadData()
    }
}

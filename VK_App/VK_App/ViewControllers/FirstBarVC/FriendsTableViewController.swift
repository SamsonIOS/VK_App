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
        static let storyId = "second"
        static let storyFriendPhotoID = "friendsVC"
    }

    // MARK: IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: Private properties

    private var sectionsDict: [Character: [(String, String, [String]?)]] = [:]
    private var sectionsTitle: [Character] = .init()
    private var friendsList = [
        User(
            friendName: Constants.firstName,
            friendImage: Constants.firstImageName,
            photosUser: [Constants.firstGomerImageName, Constants.secondGomerImageName, Constants.thirdGomerImageName]
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
            photosUser: [Constants.firstLizaImageName, Constants.secondLizaImageName, Constants.thirdLizaImageName]
        ),
    ]

    private var filteredFriendsMap: [Character: [(String, String, [String]?)]] = [:]

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarDelegate()
        sortedMethod()
    }

    // MARK: Private Methods

    private func searchBarDelegate() {
        searchBar.delegate = self
    }

    private func sortedMethod() {
        for users in friendsList {
            guard let firstChar = users.friendName.first
            else { return }

            if sectionsDict[firstChar] != nil {
                sectionsDict[firstChar]?.append((users.friendName, users.friendImage, users.photosUser))
            } else {
                sectionsDict[firstChar] = [(users.friendName, users.friendImage, users.photosUser)]
            }
        }
        sectionsTitle = Array(sectionsDict.keys)
        sectionsTitle.sort()
        filteredFriendsMap = sectionsDict
    }
}

// MARK: UITableViewDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        filteredFriendsMap.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredFriendsMap[sectionsTitle[section]]?.count ?? 0
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
            let infoForCell = filteredFriendsMap[sectionsTitle[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.addFriends(nameUser: infoForCell.0, nameImage: infoForCell.1)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: Constants.storyName, bundle: nil)
        guard let secondVC = story
            .instantiateViewController(withIdentifier: Constants.storyFriendPhotoID) as? FriendsPhotosViewController
        else { return }
        guard let list = filteredFriendsMap[sectionsTitle[indexPath.section]]?[indexPath.row] else { return }
        secondVC.configureData(nameFriend: list.0, allPhotoFriend: list.2)
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

// MARK: UISearchBarDelegate

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriendsMap = [:]

        if searchText.isEmpty {
            filteredFriendsMap = sectionsDict
        } else {
            for friends in sectionsDict {
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
        sectionsTitle = Array(filteredFriendsMap.keys)
        sectionsTitle.sort()
        tableView.reloadData()
    }
}

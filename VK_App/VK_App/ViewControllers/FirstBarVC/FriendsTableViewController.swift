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

    private var sectionsMap: [Character: [User]] = [:]
    private var sectionTitles: [Character] = .init()
    private var friends: [User] = []

    private var filteredFriendsMap: [Character: [User]] = [:] {
        didSet {
            tableView.reloadData()
        }
    }

    private var sortedCharacters: [Character] {
        filteredFriendsMap.keys.sorted()
    }

    private let networkAPIService = NetworkAPIService()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarDelegate()
        sortedMethod()
        infoAboutUser()
        getFriends()
    }

    // MARK: Private Methods

    private func infoAboutUser() {
        networkAPIService.fetchUserPhotos()
        networkAPIService.fetchGroups()
        networkAPIService.fetchSearchedGroup(group: Constants.searchGroupName)
    }

    private func getFriends() {
        networkAPIService.fetchFriends { [weak self] result in
            switch result {
            case let .success(users):
                DispatchQueue.main.async {
                    self?.friends = users
                    self?.tableView.reloadData()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func searchBarDelegate() {
        searchBar.delegate = self
    }

    private func sortedMethod() {
        for users in friends {
            guard let firstChar = users.firstName.first
            else { return }

            if sectionsMap[firstChar] != nil {
                sectionsMap[firstChar]?.append(users)
            } else {
                sectionsMap[firstChar] = [users]
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
        // guard let list = filteredFriendsMap[sectionTitles[indexPath.section]]?[indexPath.row] else { return }
        //  friendsPhotosViewController.configure(nameFriend: <#T##String#>, allPhotoFriend: <#T##[String]?#>)
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
        ) as? FriendTableViewCell
        //    let infoForCell = filteredFriendsMap[sectionTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.addFriends(user: friends[indexPath.row])

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
                // if new.lowercased().contains(searchText.lowercased()) {
                if filteredFriendsMap[firstChar] != nil {
                    filteredFriendsMap[firstChar]?.append(new)
                } else {
                    filteredFriendsMap[firstChar] = [new]
                }
            }
        }
    }
//        sectionTitles = Array(filteredFriendsMap.keys)
//        sectionTitles.sort()
//        tableView.reloadData()
}

// }

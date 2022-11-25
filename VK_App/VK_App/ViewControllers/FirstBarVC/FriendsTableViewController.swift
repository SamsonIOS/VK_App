// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// контролер со списком друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
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
    private var friends: [User] = [] {
        didSet {
            filteredFriendsMap = [:]
            sortedMethod()
        }
    }

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
        infoAboutUser()
        getFriends()
    }

    // MARK: Private Methods

    private func infoAboutUser() {}

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
        var results = [Character: [User]]()
        friends.forEach {
            guard let character = $0.firstName.first else { return }
            if results[character] != nil {
                results[character]?.append($0)
            } else {
                results[character] = [$0]
            }
        }
        filteredFriendsMap = results
    }

    private func setDidSelectRow(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.storyName, bundle: nil)
        guard let friendsPhotosViewController = storyboard
            .instantiateViewController(withIdentifier: Constants.storyFriendPhotoID) as? FriendsPhotosViewController
        else { return }
        guard let list = filteredFriendsMap[sortedCharacters[indexPath.section]]?[indexPath.row] else { return }
        friendsPhotosViewController.configure(user: list)
        navigationController?.pushViewController(friendsPhotosViewController, animated: true)
    }
}

// MARK: UITableViewDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        filteredFriendsMap.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredFriendsMap[sortedCharacters[section]]?.count ?? 0
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sortedCharacters.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedCharacters[section])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellId,
            for: indexPath
        ) as? FriendTableViewCell,
            let infoForCell = filteredFriendsMap[sortedCharacters[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.addFriends(user: infoForCell)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setDidSelectRow(indexPath: indexPath)
    }

    private func filterFriends(by prefix: String) {
        sortedMethod()
        guard
            !prefix.isEmpty,
            let prefixCharacter = prefix.first,
            var friendsMap = filteredFriendsMap[prefixCharacter]
        else {
            filteredFriendsMap = [:]
            sortedMethod()
            return
        }

        friendsMap = friendsMap.filter { user in
            user.firstName.hasPrefix(prefix)
        }

        filteredFriendsMap = [:]
        filteredFriendsMap[prefixCharacter] = friendsMap
    }
}

// MARK: UISearchBarDelegate

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriends(by: searchText)
    }
}

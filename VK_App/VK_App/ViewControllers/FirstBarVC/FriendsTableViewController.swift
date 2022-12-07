// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
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

    private let networkService = NetworkService()
    private var sectionsMap: [Character: [User]] = [:]
    private var usersToken: NotificationToken?
    private var users: Results<User>? {
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

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setMethods()
    }

    // MARK: Private Methods

    private func setMethods() {
        searchBarDelegate()
        loadRealmUser()
    }

    private func loadRealmUser() {
        guard let objects = RealmService.get(User.self) else { return }
        addUserToken(result: objects)
        if !objects.isEmpty {
            users = objects
            sortedMethod()
        } else {
            fetchFriends()
        }
    }

    private func addUserToken(result: Results<User>) {
        usersToken = result.observe { change in
            switch change {
            case .initial:
                break
            case .update:
                self.users = result
                self.sortedMethod()
                self.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchFriends() {
        networkService.fetchFriends { result in
            switch result {
            case let .success(data):
                RealmService.save(items: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func searchBarDelegate() {
        searchBar.delegate = self
    }

    private func sortedMethod() {
        var resultsMap = [Character: [User]]()
        users?.forEach {
            guard let character = $0.firstName.first else { return }
            if resultsMap[character] != nil {
                resultsMap[character]?.append($0)
            } else {
                resultsMap[character] = [$0]
            }
        }
        filteredFriendsMap = resultsMap
    }

    private func setDidSelectRow(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.storyName, bundle: nil)
        guard let friendsPhotosViewController = storyboard
            .instantiateViewController(withIdentifier: Constants.storyFriendPhotoID) as? FriendsPhotosViewController,
            let friends = filteredFriendsMap[sortedCharacters[indexPath.section]]?[indexPath.row] else { return }
        friendsPhotosViewController.configure(user: friends, userID: friends.id)

        navigationController?.pushViewController(friendsPhotosViewController, animated: true)
    }

    private func filterFriends(prefix: String) {
        sortedMethod()
        guard
            !prefix.isEmpty,
            let character = prefix.first,
            var friendsMap = filteredFriendsMap[character]
        else {
            filteredFriendsMap = [:]
            sortedMethod()
            return
        }

        friendsMap = friendsMap.filter { user in
            user.firstName.hasPrefix(prefix)
        }

        filteredFriendsMap = [:]
        filteredFriendsMap[character] = friendsMap
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
}

// MARK: UISearchBarDelegate

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriends(prefix: searchText)
    }
}

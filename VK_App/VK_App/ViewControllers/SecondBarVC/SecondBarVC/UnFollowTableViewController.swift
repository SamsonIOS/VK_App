// UnFollowTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новыми группами на которые пользователь не подписан
final class UnFollowTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let unFollowGroupCellId = "unSignGroupCell"
    }

    // MARK: Private Properties

    private let networkService = NetworkService()
    private var searchedGroups: [Group] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Private Methods

    private func fetchSearchedGroups(by prefix: String) {
        networkService.fetchSearchedGroups(by: prefix) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(groups):
                self.searchedGroups = groups
            case let .failure(error):
                print(error)
            }
        }
    }

    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = ""
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
    }
}

// MARK: UITableViewDataSource

extension UnFollowTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.unFollowGroupCellId,
                for: indexPath
            ) as? UnFollowTableViewCell
        else { return UITableViewCell() }
        let group = searchedGroups[indexPath.row]
        cell.configure(group: group)
        return cell
    }
}

// MARK: UISearchBarDelegate

extension UnFollowTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchSearchedGroups(by: searchText)
    }
}

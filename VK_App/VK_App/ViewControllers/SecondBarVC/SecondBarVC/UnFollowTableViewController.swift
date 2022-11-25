// UnFollowTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новыми группами на которые пользователь не подписан
final class UnFollowTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let unFollowGroupCellId = "unSignGroupCell"
    }

    var subscribeGroupHandler: ((Group) -> ())?

    // MARK: Public Properties

    private let networtkApi = NetworkAPIService()
    private var globalGroups: [Group] = [] {
        didSet {
            tableView.reloadData()
        }
    }

//    func configure(userGroups: [Group], subscribeGroupHandler: @escaping (Group) -> ()) {
//        globalGroups = globalGroups.filter { globalGroup in
//            !userGroups.contains { userGroup in
//                userGroup == globalGroup
//            }
//        }
//        self.subscribeGroupHandler = subscribeGroupHandler
//    }

    private func searchGroups(by prefix: String) {
        networtkApi.fetchSearchedGroups(by: prefix) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(groups):
                DispatchQueue.main.async {
                    self.globalGroups = groups
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
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
        globalGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.unFollowGroupCellId,
                for: indexPath
            ) as? UnFollowTableViewCell
        else { return UITableViewCell() }
        let group = globalGroups[indexPath.row]
        // cell.configure(by: <#T##Group#>)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addGroupToUser(groupNumber: indexPath.row)
    }

    private func addGroupToUser(groupNumber: Int) {
        guard globalGroups.count > groupNumber else { return }
        let group = globalGroups[groupNumber]
        subscribeGroupHandler?(group)
        navigationController?.popViewController(animated: true)
    }
}

extension UnFollowTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroups(by: searchText)
    }
}

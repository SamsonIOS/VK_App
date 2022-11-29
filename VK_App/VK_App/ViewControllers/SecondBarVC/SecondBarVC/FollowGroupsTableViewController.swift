// FollowGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с группами пользователя на которые он подписан
final class FollowGroupsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let segueIdentificator = "segueId"
        static let followGroupCellId = "signGroupCell"
    }

    // MARK: Private IBAction

    @IBAction private func addCellAction(segue: UIStoryboardSegue) {
        guard segue.identifier == Constants.segueIdentificator,
              let userGroups = segue.source as? UnFollowTableViewController else { return }
        tableView.reloadData()
    }

    // MARK: Private properties

    private let networkService = NetworkService()
    private var groups: [Group] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGroups()
    }

    // MARK: Private Methods

    private func fetchGroups() {
        networkService.fetchGroups { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(groups):
                self.groups = groups
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: UITableViewDataSource

extension FollowGroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.followGroupCellId,
                for: indexPath
            ) as? FollowGroupsTableViewCell
        else { return UITableViewCell() }
        cell.configure(groups[indexPath.row], networkService: networkService)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

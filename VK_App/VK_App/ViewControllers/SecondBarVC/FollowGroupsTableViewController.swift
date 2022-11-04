// FollowGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с группами пользователя на которые он подписан
final class FollowGroupsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let groupNameText = "ММА Official Group"
        static let groupImageName = "mma"
        static let segueIdentificator = "segueId"
        static let followGroupCellId = "signGroupCell"
    }

    // MARK: Private properties

    private var signGroupList = [
        Group(groupName: Constants.groupNameText, groupImage: Constants.groupImageName),
    ]

    // MARK: Private IBAction

    @IBAction private func addCellAction(segue: UIStoryboardSegue) {
        if segue.identifier == Constants.segueIdentificator {
            guard let userGroups = segue.source as? UnFollowTableViewController
            else { return }
            if let indexPath = userGroups.tableView.indexPathForSelectedRow {
                let groups = userGroups.unSignGroups[indexPath.row]
                signGroupList.append(groups)
                tableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDataSource

extension FollowGroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        signGroupList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.followGroupCellId,
                for: indexPath
            ) as? FollowGroupsTableViewCell
        else { return UITableViewCell() }

        cell.groupsInfo(signGroupList[indexPath.row])

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            signGroupList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

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

    // MARK: Private properties

    private let networkApi = NetworkAPIService()
    private var signGroupList: [Group] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserGroups()
    }

    // MARK: Private IBAction

    @IBAction private func addCellAction(segue: UIStoryboardSegue) {
        guard segue.identifier == Constants.segueIdentificator,
              let userGroups = segue.source as? UnFollowTableViewController,
              let indexPath = userGroups.tableView.indexPathForSelectedRow
        else {
            return
        }
        //  let groups = userGroups.unSignGroups[indexPath.row]
        // signGroupList.append(groups)
        tableView.reloadData()
    }

    private func getUserGroups() {
        networkApi.fetchGroups { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(groups):
                DispatchQueue.main.async {
                    self.signGroupList = groups
                }
            case let .failure(error):
                print(error.localizedDescription)
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
        let group = signGroupList[indexPath.row]
        cell.configure(group)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            //      signGroupList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

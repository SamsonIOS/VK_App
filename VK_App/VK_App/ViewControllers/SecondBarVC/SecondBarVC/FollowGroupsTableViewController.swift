// FollowGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
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

    private let realmService = RealmService()
    private let networkService = NetworkService()
    private let realm = try? Realm()
    private var groupsToken: NotificationToken?
    private var groups: Results<Group>? {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGroupsRealm()
    }

    // MARK: Private Methods

    private func loadGroupsRealm() {
        guard let objects = realm?.objects(Group.self) else { return }
        addGroupsToken(result: objects)
        if !objects.isEmpty {
            groups = objects
        } else {
            fetchGroups()
        }
    }

    private func addGroupsToken(result: Results<Group>) {
        groupsToken = result.observe { change in
            switch change {
            case .initial:
                break
            case .update:
                self.groups = result
                self.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchGroups() {
        networkService.fetchGroups { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.realmService.saveDataToRealm(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: UITableViewDataSource

extension FollowGroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.followGroupCellId,
                for: indexPath
            ) as? FollowGroupsTableViewCell
        else { return UITableViewCell() }
        guard let groups = groups?[indexPath.row] else { return UITableViewCell() }
        cell.configure(groups, networkService: networkService)
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

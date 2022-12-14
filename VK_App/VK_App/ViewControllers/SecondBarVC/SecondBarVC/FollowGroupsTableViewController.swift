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

    private var photoService: PhotoService?

    // MARK: Private IBAction

    @IBAction private func addCellAction(segue: UIStoryboardSegue) {
        guard segue.identifier == Constants.segueIdentificator,
              let userGroups = segue.source as? UnFollowTableViewController else { return }
        tableView.reloadData()
    }

    // MARK: Private properties

    private let networkService = NetworkService()
    private var groupsToken: NotificationToken?
    private var groups: Results<Group>? {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }

    // MARK: Private Methods

    private func setViewController() {
        photoService = PhotoService(container: self)
        loadGroupsRealm()
    }

    private func loadGroupsRealm() {
        guard let objects = RealmService.get(Group.self) else { return }
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
        networkService.getGroups()
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
            ) as? FollowGroupsTableViewCell,
            let groups = groups?[indexPath.row],
            let photoService = photoService else { return UITableViewCell() }
        cell.configure(groups, photoService: photoService, indexPath: indexPath.row)
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

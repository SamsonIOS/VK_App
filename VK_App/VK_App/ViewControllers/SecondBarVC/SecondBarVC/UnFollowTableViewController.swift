// UnFollowTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новыми группами на которые пользователь не подписан
final class UnFollowTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let diazGroupNameText = "Nate Diaz Group"
        static let diazGroupImageName = "nateDiaz"
        static let khabibGroupNameText = "Khabib Nurmagomedov Group"
        static let khabibGroupImageName = "khabib"
        static let conorGroupNameText = "Conor MacGregor Group"
        static let conorGroupImageName = "macgregor"
        static let mikeGroupNameText = "Mike Tyson Group"
        static let mikeGroupImageName = "tyson"
        static let romeroGroupNameText = "Yeol Romero Group"
        static let romeroGroupImageName = "yeolRomero"
        static let unFollowGroupCellId = "unSignGroupCell"
    }

    // MARK: Public Properties

    var unSignGroups = [
        Group(groupName: Constants.diazGroupNameText, groupImage: Constants.diazGroupImageName),
        Group(groupName: Constants.khabibGroupNameText, groupImage: Constants.khabibGroupImageName),
        Group(groupName: Constants.conorGroupNameText, groupImage: Constants.conorGroupImageName),
        Group(groupName: Constants.mikeGroupNameText, groupImage: Constants.mikeGroupImageName),
        Group(groupName: Constants.romeroGroupNameText, groupImage: Constants.romeroGroupImageName),
    ]
}

// MARK: UITableViewDataSource

extension UnFollowTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        unSignGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.unFollowGroupCellId,
                for: indexPath
            ) as? UnFollowTableViewCell
        else { return UITableViewCell() }

        cell.unFollowGroupInfo(unSignGroups[indexPath.row])
        return cell
    }
}

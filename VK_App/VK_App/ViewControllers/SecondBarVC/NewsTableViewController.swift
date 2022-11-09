// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостями
final class NewsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let newsCellID = "newsCell"
        static let firstUserImageName = "bart"
        static let firstUserName = "Bart Simpson"
        static let firstPostImageName = "dark"
        static let secondUserImageName = "shupalz"
        static let secondUserName = "Marsianin"
        static let secondPostImageName = "inoplat"
    }

    // MARK: Private properties

    private var post = [
        News(
            userImageName: Constants.firstUserImageName,
            userName: Constants.firstUserName,
            overviewPost: OverviewPost.bartPostText,
            postImageName: Constants.firstPostImageName
        ),
        News(
            userImageName: Constants.secondUserImageName,
            userName: Constants.secondUserName,
            overviewPost: OverviewPost.shupalzPostText,
            postImageName: Constants.secondPostImageName
        )
    ]
}

// MARK: UITableViewDataSource

extension NewsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.newsCellID, for: indexPath) as? NewsTableViewCell
        else { return UITableViewCell() }
        cell.setCellInfo(post[indexPath.row])
        return cell
    }
}

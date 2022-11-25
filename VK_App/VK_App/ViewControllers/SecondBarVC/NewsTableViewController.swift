// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостями
final class NewsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let newsCellID = "newsCell"
    }
}

// MARK: UITableViewDataSource

extension NewsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.newsCellID, for: indexPath) as? NewsTableViewCell
        else { return UITableViewCell() }
        return cell
    }
}

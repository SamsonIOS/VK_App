// Extension + PhotoService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Расширяем фото сервис для использования его в нужном нам контроллере
extension PhotoService {
    class TableViewController: DataReloadable {
        let table: UITableViewController

        init(table: UITableViewController) {
            self.table = table
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

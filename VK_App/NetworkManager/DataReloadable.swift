// DataReloadable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол содержащий функцию для обновления ячеек
protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

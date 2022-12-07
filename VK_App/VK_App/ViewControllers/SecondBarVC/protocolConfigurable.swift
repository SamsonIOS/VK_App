// protocolConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// typealias Ячейки и протокола
typealias NewsCell = UITableViewCell & NewsConfigurable

/// протокол для вызова функции в ячейке
protocol NewsConfigurable {
    func configure(news: NewsFeed, network: NetworkService)
}

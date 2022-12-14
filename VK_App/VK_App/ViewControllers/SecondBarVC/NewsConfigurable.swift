// NewsConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// typealias Ячейки и протокола
typealias NewsCell = UITableViewCell & NewsConfigurable

/// протокол вызова функции для конфигурирования ячейки
protocol NewsConfigurable {
    func configure(news: NewsFeed)
}

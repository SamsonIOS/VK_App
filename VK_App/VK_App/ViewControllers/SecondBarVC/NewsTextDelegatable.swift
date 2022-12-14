// NewsTextDelegatable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// протокол с фукнцией для ячейки с текстом
protocol NewsPostCellDelegate: AnyObject {
    func didTappedShowMore(_ cell: NewsTextCell)
}

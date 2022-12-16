// NewsTextDelegatable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Показ полного текста новости, при нажатии 
protocol NewsPostCellDelegate: AnyObject {
    func didTappedShowMore(_ cell: NewsTextCell)
}

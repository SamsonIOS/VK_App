// DateFormatter + Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для конвертирования даты в хедер ячейке
extension DateFormatter {
    // MARK: Constants

    private enum Constants {
        static let dateStyle = "MM-dd-yyyy HH:mm"
    }

    // MARK: Public Methods

    static func convert(dateValue: Double) -> String {
        let truncatedTime = TimeInterval(dateValue)
        let date = Date(timeIntervalSince1970: truncatedTime)
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateStyle
        return formatter.string(from: date)
    }
}

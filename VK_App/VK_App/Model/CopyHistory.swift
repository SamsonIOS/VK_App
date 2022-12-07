// CopyHistory.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Доступ к фото поста
struct CopyHistory: Decodable {
    /// Привязанности
    let attachments: [CopyHistoryAttachment]?
}

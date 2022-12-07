// GroupResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Массив групп
struct GroupResponse: Decodable {
    /// Группы
    let groups: [Group]

    enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}

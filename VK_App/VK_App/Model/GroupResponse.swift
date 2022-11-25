// GroupResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель с массивом групп
struct GroupResponse: Decodable {
    let groups: [Group]

    enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}

// GroupResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// массив групп
struct GroupResponse: Decodable {
    let groups: [Group]

    enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}

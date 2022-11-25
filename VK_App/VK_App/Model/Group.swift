// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель группы
final class Group: Decodable {
    var id: Int
    var name: String
    var photo50Path: String
    var screenName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo50Path = "photo_50"
        case screenName = "screen_name"
    }
}

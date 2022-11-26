// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Группы
final class Group: Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo50Path: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo50Path = "photo_50"
    }
}

// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группы
final class Group: Object, Decodable {
    /// Айди группы
    @Persisted(primaryKey: true) var id: Int
    /// Имя группы
    @Persisted var name: String
    /// Фото группы
    @Persisted var photoPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photoPath = "photo_50"
    }
}

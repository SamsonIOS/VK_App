// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группы
final class Group: Object, Decodable {
    // MARK: Constants
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case photoPath = "photo_50"
    }
    
    // MARK: Public properties
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var photoPath: String
}

// User.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Пользователь
final class User: Object, Decodable {
    // MARK: Constants
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case userImagePath = "photo_100"
    }
    
    // MARK: Public properties
    @Persisted(primaryKey: true) var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var userImagePath: String
}

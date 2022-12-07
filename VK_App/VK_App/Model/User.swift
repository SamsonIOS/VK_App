// User.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Пользователь
final class User: Object, Decodable {
    /// Айди пользователя
    @Persisted(primaryKey: true) var id: Int
    /// Фамилия пользователя
    @Persisted var firstName: String
    /// Имя пользователя
    @Persisted var lastName: String
    /// Фото пользователя
    @Persisted var userImagePath: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case userImagePath = "photo_100"
    }
}

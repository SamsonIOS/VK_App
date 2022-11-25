// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель пользователя
class User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let userImagePath: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case userImagePath = "photo_100"
    }
}

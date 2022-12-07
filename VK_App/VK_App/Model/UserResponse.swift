// UserResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// UserResponse результат
struct UserResponse: Decodable {
    /// Друзья
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

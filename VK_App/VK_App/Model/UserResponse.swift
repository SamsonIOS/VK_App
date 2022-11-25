// UserResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// UserResponse result
struct UserResponse: Decodable {
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

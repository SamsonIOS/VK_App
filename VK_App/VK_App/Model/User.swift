// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Response result
struct UserResult: Decodable {
    let response: UserResponse
}

/// UserResponse result
struct UserResponse: Decodable {
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

/// Модель пользователя
class User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    // let status: String?
    let avatarImagePath: String
    //  let hasMobile: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        //  case status
        case avatarImagePath = "photo_100"
        //  case hasMobile = "has_mobile"
    }
}

/// Структура описывающая группы вк
struct Group {
    var groupName: String
    var groupImage: String
}

/// Структура описывающая пост в ленте
struct News {
    let userImageName: String
    let userName: String
    let overviewPost: String
    let postImageName: String
}

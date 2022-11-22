// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура описывающая друзей
struct User {
    var friendName: String
    var friendImage: String
    var userPhotoNames: [String]?
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

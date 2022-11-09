// Model.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура описывающая друзей
struct User {
    var friendName: String
    var friendImage: String
}

/// Структура описывающая группы вк
struct Group {
    var groupName: String
    var groupImage: String
}

/// Структура описывающая пост в ленте
struct News {
    var userImageName: String
    var userName: String
    var overviewPost: String
    var postImageName: String
}

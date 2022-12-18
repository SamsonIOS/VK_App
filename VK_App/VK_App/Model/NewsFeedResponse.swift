// NewsFeedResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости, группы, друзья
struct NewsFeedResponse: Decodable {
    /// Новости
    var news: [NewsFeed]
    /// Группы
    let groups: [Group]
    /// Друзья
    let friends: [User]
    /// Получение следующей страницы новостей
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
        case nextFrom = "next_from"
    }
}

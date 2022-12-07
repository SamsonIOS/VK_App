// NewsFeedResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости, группы, друзья
struct NewsFeedResponse: Decodable {
    /// Новости
    let news: [NewsFeed]
    /// Группы
    let groups: [Group]
    /// Друзья
    let friends: [User]

    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
    }
}

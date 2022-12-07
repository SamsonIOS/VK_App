// NewsFeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости
final class NewsFeed: Decodable {
    /// Айди
    var id: Int
    /// Айди поста
    var sourceID: Int
    /// Текст поста
    var text: String
    /// Имя автора поста
    var authorName: String?
    /// Фото автора поста
    var avatarPath: String?
    /// Дата поста
    var date: Int
    /// Тип поста
    var type: NewsItemType?
    /// Лайки поста
    var likes: Likes
    /// Комменты поста
    var comments: Comments
    /// Репосты поста
    var reposts: Reposts
    /// Количество просмотров поста
    var views: Views
    /// Параметр для доступа к фото в посте
    var copyHistory: [CopyHistory]?

    enum CodingKeys: String, CodingKey {
        case id
        case sourceID = "source_id"
        case text
        case date
        case likes
        case comments
        case reposts
        case views
    }

    enum NewsItemType {
        case text
        case image
    }
}

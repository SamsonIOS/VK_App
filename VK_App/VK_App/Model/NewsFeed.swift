// NewsFeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости
final class NewsFeed: Decodable {
    var id: Int
    var sourceID: Int
    var text: String
    var authorName: String?
    var avatarPath: String?
    var date: Int
    var type: NewsItemType?
    var likes: Likes
    var comments: Comments
    var reposts: Reposts
    var views: Views
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

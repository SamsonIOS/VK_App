// NewsFeedResult.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Результат запроса на получение новостей
struct NewsFeedResult: Decodable {
    /// Запрос
    let response: NewsFeedResponse
}

// UserPhotoResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Результат парсинга запроса на получение фотографий пользователя
struct UserPhotoResponse: Decodable {
    let photos: [UserPhotoResults]

    enum CodingKeys: String, CodingKey {
        case photos = "items"
    }
}

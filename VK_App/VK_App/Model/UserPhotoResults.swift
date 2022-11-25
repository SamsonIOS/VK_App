// UserPhotoResults.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Результаты парсинга запрсоса на получение объектов с путями фотографий пользователя
struct UserPhotoResults: Decodable {
    let photos: [UserPhotoUrl]

    enum CodingKeys: String, CodingKey {
        case photos = "sizes"
    }
}

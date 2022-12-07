// UserPhotoResult.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Результат запроса на получение фотографий пользователя
struct UserPhotoResult: Decodable {
    /// Запрос
    let response: UserPhotoResponse
}

// UserPhotoResults.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Результаты парсинга запрсоса на получение объектов с путями фотографий пользователя
final class UserPhotoResults: Object, Decodable {
    /// Айди фото пользователя
    @Persisted(primaryKey: true) var id: Int
    /// Фото пользователя при переходе в его профиль
    @Persisted var photos = List<UserPhoto>()
    /// Айди пользователя
    @Persisted var ownerID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case photos = "sizes"
        case ownerID = "owner_id"
    }
}

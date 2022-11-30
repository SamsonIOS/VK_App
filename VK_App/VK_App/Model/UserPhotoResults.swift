// UserPhotoResults.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Результаты парсинга запрсоса на получение объектов с путями фотографий пользователя
final class UserPhotoResults: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var photos = List<UserPhoto>()
    @Persisted var ownerID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case photos = "sizes"
        case ownerID = "owner_id"
    }

}

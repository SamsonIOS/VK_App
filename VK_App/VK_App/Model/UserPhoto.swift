// UserPhoto.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фотографии пользователя
final class UserPhoto: Object, Decodable {
    /// адрес на фото друга
    @Persisted var url: String
}

// UserPhoto.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фотографии пользователя
final class UserPhoto: Object, Decodable {
    @Persisted var url: String
}

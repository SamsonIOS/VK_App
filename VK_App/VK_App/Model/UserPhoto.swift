// UserPhoto.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фотографии пользователя
final class UserPhoto: Object, Decodable {
    // MARK: Public properties
    @Persisted var url: String
}

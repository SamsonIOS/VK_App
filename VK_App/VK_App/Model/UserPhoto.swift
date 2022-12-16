// UserPhoto.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фотографии пользователя
final class UserPhoto: Object, Decodable {
    /// Высота
    let height: Int?
    /// Ширина
    let width: Int?
    /// адрес на фото друга
    @Persisted var url: String
    /// Cоотношение сторон
    ///
    var aspectRatio: CGFloat {
        guard let height,
              let width
        else { return 0 }
        return CGFloat(height) / CGFloat(width)
    }
}

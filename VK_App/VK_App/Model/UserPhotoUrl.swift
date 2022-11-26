// UserPhotoUrl.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Фотографии пользователя
final class UserPhotoUrl: Decodable {
    @objc dynamic var url: String
}

// UserPhoto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Фотографии пользователя
final class UserPhoto: Decodable {
    @objc dynamic var url: String
}

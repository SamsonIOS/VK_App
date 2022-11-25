// UserPhotoUrl.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

import RealmSwift

/// Путь до фотографии пользователя
final class UserPhotoUrl: Decodable {
    @objc dynamic var url: String
}

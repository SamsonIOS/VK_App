// ResultsCopy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Результат парсинга запроса на получение фотографий поста
struct CopyHistoryAttachment: Decodable {
    let photo: UserPhotoResults?
}

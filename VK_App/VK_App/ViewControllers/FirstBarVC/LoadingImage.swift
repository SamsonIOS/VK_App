// LoadingImage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

import Alamofire

/// Класс для загрузки и кеширования картинок
final class ImageLoader {
    // MARK: - Public properties

    static let shared = ImageLoader()

    // MARK: - Private properties

    private let decoder = JSONDecoder()
    private var imagesMap: [String: Data] = [:]

    // MARK: - Initializers

    private init() {}

    // MARK: - Public methods

    func getImage(imagePosterPath: String, completion: @escaping (Data) -> ()) {
        if let data = imagesMap[imagePosterPath] {
            completion(data)
        } else {
            loadImage(imagePath: imagePosterPath, completion: completion)
        }
    }

    // MARK: - Private methods

    private func loadImage(imagePath: String, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: imagePath) else { return }
        AF.request(url).responseData { [weak self] response in
            guard let data = response.data else { return }
            self?.imagesMap[imagePath] = data
            completion(data)
        }
    }
}

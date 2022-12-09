// UIImageView + Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Загрузка и кеширование картинок
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}

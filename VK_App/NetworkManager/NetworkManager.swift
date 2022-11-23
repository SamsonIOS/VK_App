// NetworkManager.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Настройки апи для получения нужных запросов
struct NetworkManager {
    // MARK: Constants

    private enum Constants {
        static let baseURL = "https://api.vk.com/method/"
        static let acessToken = "?&access_token=\(Session.shared.token)"
        static let friendFields = "&fields=first_name"
        static let getFriends = "friends.get"
        static let getUserPhoto = "photos.getAll"
        static let getGroups = "groups.get"
        static let getSearchGroup = "groups.search"
        static let searchQueryText = "&q="
        static let version = "&v=5.81"
    }

    // MARK: - Public Methods

    func getFriends() {
        let path = "\(Constants.getFriends)\(Constants.acessToken)\(Constants.friendFields)\(Constants.version)"
        let url = "\(Constants.baseURL)\(path)"
        AF.request(url).responseJSON { response
            in
            guard let value = response.value else { return }
            print(value)
        }
    }

    func getUserPhotos() {
        let path =
            "\(Constants.getUserPhoto)\(Constants.acessToken)\(Constants.friendFields)\(Constants.version)"
        let url = "\(Constants.baseURL)\(path)"
        AF.request(url).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }

    func getGroups() {
        let path =
            "\(Constants.getGroups)\(Constants.acessToken)\(Constants.friendFields)\(Constants.version)"
        let url = "\(Constants.baseURL)\(path)"
        AF.request(url).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }

    func getSearchedGroup(group: String) {
        let path =
            "\(Constants.getSearchGroup)\(Constants.acessToken)" +
            "\(Constants.friendFields)\(Constants.searchQueryText)\(group)\(Constants.version)"
        let url = "\(Constants.baseURL)\(path)"
        AF.request(url).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
}

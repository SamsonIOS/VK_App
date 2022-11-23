// NetworkAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// VK API Сервис
struct NetworkAPIService {
    // MARK: Constants

    private enum Constants {
        static let baseURL = "https://api.vk.com/method/"
        static let acessToken = "access_token"
        static let friendFields = "fields"
        static let friendFieldsValue = "nickname"
        static let getFriends = "friends.get"
        static let getUserPhoto = "photos.getAll"
        static let getGroups = "groups.get"
        static let getSearchGroup = "groups.search"
        static let searchQueryText = "&q="
        static let version = "5.81"
        static let scheme = "https"
        static let host = "oauth.vk.com"
        static let path = "/authorize"
        static let clientIDText = "client_id"
        static let displayText = "display"
        static let mobileText = "mobile"
        static let redirectText = "redirect_uri"
        static let blankText = "https://oauth.vk.com/blank.html"
        static let scopeText = "scope"
        static let scopeValue = "262150"
        static let responseTypeText = "response_type"
        static let toketText = "token"
        static let versionText = "v"
        static let versionValueText = "5.68"
        static let acessTokenParameter = "access_token"
        static let versionParameter = "v"
        static let versionValue = "5.131"
        static let extendedParameter = "extended"
        static let extendedValue = "1"
        static let queryParameter = "q"
    }

    // MARK: - Public Methods

    func urlComponents() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.clientIDText, value: Session.shared.userID),
            URLQueryItem(name: Constants.displayText, value: Constants.mobileText),
            URLQueryItem(
                name: Constants.redirectText,
                value:
                Constants.blankText
            ),
            URLQueryItem(name: Constants.scopeText, value: Constants.scopeValue),
            URLQueryItem(name: Constants.responseTypeText, value: Constants.toketText),
            URLQueryItem(name: Constants.versionText, value: Constants.versionValueText)
        ]
        guard let components = urlComponents.url else { return nil }
        let request = URLRequest(url: components)
        return request
    }

    func fetchFriends() {
        let parameters: Parameters = [
            Constants.acessToken: Session.shared.token,
            Constants.friendFields: Constants.friendFieldsValue,
            Constants.versionText: Constants.version
        ]
        let path = "\(Constants.baseURL)\(Constants.getFriends)"
        AF.request(path, parameters: parameters).responseData { response in
            print(response.value)
        }
    }

    func fetchUserPhotos() {
        let parameters: Parameters = [
            Constants.acessTokenParameter: Session.shared.token,
            Constants.versionParameter: Constants.versionValue,
            Constants.extendedParameter: Constants.extendedValue,
        ]
        let path = "\(Constants.baseURL)\(Constants.getUserPhoto)"
        AF.request(path, parameters: parameters).responseData { response in
            print(response.value)
        }
    }

    func fetchGroups() {
        let parameters: Parameters = [
            Constants.acessToken: Session.shared.token,
            Constants.versionText: Constants.version,
            Constants.extendedParameter: Constants.extendedValue
        ]
        let path = "\(Constants.baseURL)\(Constants.getGroups)"
        AF.request(path, parameters: parameters).responseData { response in
            print(response.value)
        }
    }

    func fetchSearchedGroup(group: String) {
        let parameters: Parameters = [
            Constants.acessTokenParameter: Session.shared.token,
            Constants.versionParameter: Constants.versionValue,
            Constants.queryParameter: group
        ]
        let path = "\(Constants.baseURL)\(Constants.getSearchGroup)"
        AF.request(path, parameters: parameters).responseData { response in
            print(response.value)
        }
    }
}

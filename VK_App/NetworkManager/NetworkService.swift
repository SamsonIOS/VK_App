// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import PromiseKit

/// VK API Сервис
struct NetworkService {
    // MARK: Constants

    private enum Constants {
        static let baseURL = "https://api.vk.com/method/"
        static let friendFields = "fields"
        static let friendFieldsValue = "nickname, photo_100"
        static let getFriends = "friends.get"
        static let getUserPhoto = "photos.getAll"
        static let getGroups = "groups.get"
        static let getSearchGroup = "groups.search"
        static let getNewsFeed = "newsfeed.get"
        static let filters = "filters"
        static let post = "post"
        static let scheme = "https"
        static let host = "oauth.vk.com"
        static let path = "/authorize"
        static let clientIDText = "client_id"
        static let displayText = "display"
        static let mobileText = "mobile"
        static let redirectText = "redirect_uri"
        static let blankText = "https://oauth.vk.com/blank.html"
        static let scopeText = "scope"
        static let scopeValue = "8194"
        static let responseTypeText = "response_type"
        static let toketText = "token"
        static let versionText = "v"
        static let acessTokenParameter = "access_token"
        static let versionParameter = "v"
        static let versionValue = "5.131"
        static let extendedParameter = "extended"
        static let extendedValue = "1"
        static let queryParameter = "q"
        static let ownerIDParameter = "owner_id"
    }

    // MARK: Public Methods

    func urlComponents() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.clientIDText, value: Session.shared.userID),
            URLQueryItem(name: Constants.displayText, value: Constants.mobileText),
            URLQueryItem(name: Constants.redirectText, value: Constants.blankText),
            URLQueryItem(name: Constants.scopeText, value: Constants.scopeValue),
            URLQueryItem(name: Constants.responseTypeText, value: Constants.toketText),
            URLQueryItem(name: Constants.versionText, value: Constants.versionValue)
        ]
        guard let components = urlComponents.url else { return nil }
        let request = URLRequest(url: components)
        return request
    }

    func fetchFriends() -> Promise<[User]> {
        let parameters: Parameters = [
            Constants.acessTokenParameter: Session.shared.token,
            Constants.friendFields: Constants.friendFieldsValue,
            Constants.versionParameter: Constants.versionValue
        ]
        let path = "\(Constants.baseURL)\(Constants.getFriends)"
        let promise = Promise<[User]> { resolver in
            AF.request(path, parameters: parameters).responseData { response in
                guard let data = response.data else { return }
                do {
                    let request = try JSONDecoder().decode(UserResult.self, from: data)
                    resolver.fulfill(request.response.users)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }

    func fetchUserPhotos(for userID: Int) -> Promise<UserPhotoResult> {
        let parameters: Parameters = [
            Constants.acessTokenParameter: Session.shared.token,
            Constants.versionParameter: Constants.versionValue,
            Constants.extendedParameter: Constants.extendedValue,
            Constants.ownerIDParameter: userID
        ]
        let path = "\(Constants.baseURL)\(Constants.getUserPhoto)"
        let promise = Promise<UserPhotoResult> { resolver in
            AF.request(path, parameters: parameters).responseData { response in
                guard let data = response.data else { return }
                do {
                    let result = try JSONDecoder().decode(UserPhotoResult.self, from: data)
                    resolver.fulfill(result)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }

    func getGroups() {
        let opq = OperationQueue()

        let request = getRequest()
        let getDataOperaion = GetDataOperations(request: request)
        opq.addOperation(getDataOperaion)

        let parseData = ParseData()
        parseData.addDependency(getDataOperaion)
        opq.addOperation(parseData)

        let saveToRealm = ReloadTableController()
        saveToRealm.addDependency(parseData)
        OperationQueue.main.addOperation(saveToRealm)
    }

    func fetchNews() -> Promise<NewsFeedResponse> {
        let parameters: Parameters = [
            Constants.acessTokenParameter: Session.shared.token,
            Constants.filters: Constants.post,
            Constants.versionParameter: Constants.versionValue
        ]
        let path = "\(Constants.baseURL)\(Constants.getNewsFeed)"
        let promise = Promise<NewsFeedResponse> { resolver in
            AF.request(path, parameters: parameters).responseData { response in
                guard let data = response.data else { return }
                do {
                    let request = try JSONDecoder().decode(NewsFeedResult.self, from: data)
                    resolver.fulfill(request.response)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }

    // MARK: Private Methods

    private func getRequest() -> DataRequest {
        let baseURL = Constants.baseURL
        let version = Constants.versionValue
        let token = Session.shared.token
        let path = Constants.getGroups
        let parameters: Parameters = [
            Constants.versionParameter: version,
            Constants.extendedParameter: Constants.extendedValue,
            Constants.acessTokenParameter: token
        ]
        let url = (baseURL + path)
        let request = AF.request(url, parameters: parameters)
        return request
    }
}

/// Загрузка и кеширование картинок
final class LoadingImage {
    // MARK: - Public properties

    static let shared = LoadingImage()

    // MARK: - Private properties

    private var imagesMap: [String: Data] = [:]

    // MARK: - Init

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
        AF.request(url).responseData { response in
            guard let data = response.data else { return }
            self.imagesMap[imagePath] = data
            completion(data)
        }
    }
}

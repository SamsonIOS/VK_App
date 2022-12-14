// NetworkNewsService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Класс с запросом в сеть для получения новостей
final class NetworkNewsService {
    private enum Constants {
        static let startTime = "start_time"
        static let nextFrom = "next_from"
        static let acessTokenParameter = "access_token"
        static let versionParameter = "v"
        static let versionValue = "5.131"
        static let baseURL = "https://api.vk.com/method/"
        static let getNewsFeed = "newsfeed.get"
        static let filters = "filters"
        static let post = "post"
        static let count = "count"
        static let countValue = "200"
    }

    // MARK: Public Methods

    func fetchNews(
        startTime: Double? = nil,
        nextFrom: String? = nil,
        completion: @escaping (Result<NewsFeedResponse, Error>) -> ()
    ) {
        var parameters: Parameters = [
            Constants.acessTokenParameter: Session.shared.token,
            Constants.filters: Constants.post,
            Constants.versionParameter: Constants.versionValue,
            Constants.count: Constants.countValue,
            Constants.nextFrom: nextFrom
        ]

        if let startTime = startTime {
            parameters[Constants.startTime] = startTime
        }

        let path = "\(Constants.baseURL)\(Constants.getNewsFeed)"
        AF.request(path, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
            do {
                let request = try JSONDecoder().decode(NewsFeedResult.self, from: data)
                completion(.success(request.response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

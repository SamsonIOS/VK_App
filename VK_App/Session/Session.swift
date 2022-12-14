// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Инфо о сессии юзера
final class Session {
    // MARK: Constants

    private enum Constants {
        static let userID = "51503794"
    }

    // MARK: Public properties

    static let shared = Session()
    let userID = Constants.userID
    var token = String()

    // MARK: Init

    private init() {}
}

// ParseData.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Структура поста полученная из интернета
final class ParseData: Operation {
    // MARK: Public Properties

    var outputData: [Group] = []

    // MARK: Public Methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperations,
              let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(GroupResult.self, from: data)
            outputData = response.response.groups
        } catch {
            print(error.localizedDescription)
        }
    }
}

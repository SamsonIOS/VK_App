// ParseGroupData.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Операция парсинга Group
final class ParseGroupData: Operation {
    // MARK: Public Properties

    var group: [Group] = []

    // MARK: Public Methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperations,
              let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(GroupResult.self, from: data)
            group = response.response.groups
        } catch {
            print(error.localizedDescription)
        }
    }
}

// ReloadTableController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Обновление таблицы
final class ReloadTableController: Operation {
    // MARK: Public Methods

    override func main() {
        guard let getParseData = dependencies.first as? ParseData else { return }
        let parseData = getParseData.outputData
        do {
            let realm = try Realm()
            guard let oldData = RealmService.get(Group.self) else { return }
            try realm.write {
                realm.delete(oldData)
                realm.add(parseData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

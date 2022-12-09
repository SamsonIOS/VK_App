// ReloadTable.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Обновление данных в реалм
final class ReloadTable: Operation {
    // MARK: Public Methods

    override func main() {
        guard let getParseData = dependencies.first as? ParseGroupData else { return }
        let parseData = getParseData.group
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

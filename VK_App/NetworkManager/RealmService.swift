// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Realm Service

final class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    static func save<T: Object>(
        items: [T],
        config: Realm.Configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true),
        update: Bool = true
    ) {
        // print(config.fileURL!)

        do {
            let realm = try Realm(configuration: deleteIfMigration)

            try realm.write {
                realm.add(items, update: .modified)
            }

        } catch {
            print(error)
        }
    }

    static func get<T: Object>(
        _ type: T.Type,
        config: Realm.Configuration = Realm.Configuration.defaultConfiguration
    ) -> Results<T>? {
        do {
            let realm = try Realm(configuration: deleteIfMigration)
            return realm.objects(type)
        } catch {
            print(error)
        }
        return nil
    }
}

//
//  Repository.swift
//  Pokemon
//
//  Created by Atsushi Miyake on 2018/05/06.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift

public final class Repository<ObjectType: Object> {

    var realm: Realm

    static var defaultRealm: Realm? {
        return self.realm(name: "default")
    }

    static func realm(name: String) -> Realm? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let realmURL = documentsURL?.appendingPathComponent("\(name).realm")

        var config = Realm.Configuration(schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    if (oldSchemaVersion < 1) {}
                })

        config.fileURL = realmURL!
        let realm = try! Realm(configuration: config)
        return realm
    }

    init(realm: Realm = Repository<ObjectType>.defaultRealm!) {
        self.realm = realm
    }

    func single() -> ObjectType? {
        return self.realm.objects(ObjectType.self).first
    }

    func find(pk: Int) -> ObjectType? {
        return self.findAll().filter("id == %@", pk).first
    }

    func findAll() -> Results<ObjectType> {
        return self.realm.objects(ObjectType.self)
    }

    func findAll(predicate: NSPredicate) -> Results<ObjectType> {
        return self.findAll().filter(predicate)
    }

    public func add(_ objects: [ObjectType]) {
        try! self.realm.write {
            self.realm.add(objects, update: true)
        }
    }

    func delete(_ objects: [ObjectType]) {
        try! realm.write {
            self.realm.delete(objects)
        }
    }
}

//
//  Repository.swift
//  Pokemon
//
//  Created by Atsushi Miyake on 2018/05/06.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift

final class Repository<ObjectType: Object> {

    var realm: Realm

    init(realm: Realm) {
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

    func add(_ objects: [ObjectType]) {
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

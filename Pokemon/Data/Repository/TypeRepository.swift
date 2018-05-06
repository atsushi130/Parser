//
// Created by Atsushi Miyake on 2018/05/06.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift

extension Repository where ObjectType: Type {

    public static var repository: Repository<ObjectType> {
        return Repository<ObjectType>()
    }

    public func findBy(name: String) -> ObjectType? {
        let codePredicate = NSPredicate(format: "name == %@", name)
        return Repository<ObjectType>.repository.findAll(predicate: codePredicate).first
    }
}

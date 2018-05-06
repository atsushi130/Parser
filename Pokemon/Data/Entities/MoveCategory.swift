//
// Created by Atsushi Miyake on 2018/05/06.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift

public final class MoveCategory: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""

    public convenience init(moveCategory: [String: Any]) {
        self.init()
        self.id   = moveCategory["id"] as! Int
        self.name = moveCategory["name"] as! String
    }

    public override static func primaryKey() -> String? {
        return "id"
    }

    public static var repository: Repository<MoveCategory> {
        return Repository<MoveCategory>()
    }
}

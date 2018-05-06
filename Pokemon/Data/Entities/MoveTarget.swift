//
// Created by Atsushi Miyake on 2018/05/06.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift

public final class MoveTarget: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""

    public convenience init(moveTarget: [String: Any]) {
        self.init()
        self.id   = moveTarget["id"] as! Int
        self.name = moveTarget["name"] as! String
    }

    public override static func primaryKey() -> String? {
        return "id"
    }

    public static var repository: Repository<MoveTarget> {
        return Repository<MoveTarget>()
    }
}

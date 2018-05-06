//
// Created by Atsushi Miyake on 2018/05/06.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift

public final class AdditionEffect: Object {

    @objc public dynamic var id = 0
    @objc public dynamic var name = ""

    public convenience init(additionEffect: [String: Any]) {
        self.init()
        self.id = additionEffect["id"] as! Int
        self.name = additionEffect["name"] as! String
    }

    public override static func primaryKey() -> String? {
        return "id"
    }

    public static var repository: Repository<AdditionEffect> {
        return Repository<AdditionEffect>()
    }
}

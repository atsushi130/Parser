//
// Created by Atsushi Miyake on 2018/05/09.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift

public final class Ability: Object {

    @objc public dynamic var id = 0
    @objc public dynamic var name = ""
    @objc public dynamic var effect = ""

    public convenience init(ability: [String: Any]) {
        self.init()
        let id = Int((ability["id"] as! String).replacingOccurrences(of:" ", with:""))!
        self.id = id
        self.name = ability["name"] as! String
        self.effect = ability["effect"] as! String
    }

    public override static func primaryKey() -> String? {
        return "id"
    }

    public static var repository: Repository<Ability> {
        return Repository<Ability>()
    }
}

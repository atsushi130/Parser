//
// Created by Atsushi Miyake on 2018/05/06.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift

public final class Move: Object {

    @objc public dynamic var id = 0
    @objc public dynamic var name = ""
    @objc public dynamic var accuracy = 0
    @objc public dynamic var additionEffect: AdditionEffect? = nil
    @objc public dynamic var additionProbability: Double = 0.0
    @objc public dynamic var category: MoveCategory!
    @objc public dynamic var despondency: Double = 0.0
    @objc public dynamic var direct = true
    @objc public dynamic var information = ""
    @objc public dynamic var magicCoat = true
    @objc public dynamic var parroting = true
    @objc public dynamic var power = 0
    @objc public dynamic var pp = 0
    @objc public dynamic var priority = 0
    @objc public dynamic var protect = true
    @objc public dynamic var steal = true
    @objc public dynamic var target = "" // 型を MoveTarget にしたい
    @objc public dynamic var type: Type!
    @objc public dynamic var vital: Bool = true

    public convenience init(move: [String: Any]) {
        self.init()
        let id = Int((move["id"] as! String).replacingOccurrences(of:" ", with:""))!
        self.id = id
        self.name = move["name"] as! String
        self.accuracy = Int(move["accuracy"] as! String) ?? 0

        let additionEffect: String?
        if let additionEffect = move["additionEffect"] as? String {
            if additionEffect == "-" {
                self.additionEffect = nil
            } else {
                self.additionEffect = AdditionEffect.repository.findBy(name: additionEffect)
            }
        } else {
            self.additionEffect = nil
        }

        if let additionProbability = move["additionProbabiliry"] as? String {
            if additionProbability != "-" {
                let value = Double(additionProbability.replacingOccurrences(of:"%", with:""))!
                self.additionProbability = value/100
            }
        }

        self.category = MoveCategory.repository.findBy(name: move["category"] as! String)!

        if let despondency = move["despondency"] as? String {
            if despondency != "-" {
                let value = Double(despondency.replacingOccurrences(of:"%", with:""))!
                self.despondency = value/100
            }
        }

        self.direct = Bool(move["direct"] as! String)!
        self.information = move["information"] as! String
        self.magicCoat = Bool(move["magicCoat"] as! String)!
        self.parroting = Bool(move["parroting"] as! String)!
        self.power = Int(move["power"] as! String) ?? 0
        self.pp = Int(move["pp"] as! String)!
        self.priority = Int(move["priority"] as! String)!
        self.protect = Bool(move["protect"] as! String)!
        self.steal = Bool(move["steal"] as! String)!
        self.target = move["target"] as! String
        self.type = Type.repository.findBy(name: move["type"] as! String)!

        if let vital = move["vital"] as? String {
            if vital == "-" {
                self.vital = false
            } else {
                self.vital = Bool(vital)!
            }
        } else {
            self.vital = false
        }
    }

    public override static func primaryKey() -> String? {
        return "id"
    }

    public static var repository: Repository<Move> {
        return Repository<Move>()
    }
}

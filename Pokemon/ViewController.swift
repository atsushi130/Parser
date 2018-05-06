//
//  ViewController.swift
//  Pokemon
//
//  Created by Atsushi Miyake on 2018/05/05.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import Data

class ViewController: UIViewController {

    var resource: Resource = .pokemon

    var pokemons: [Item]  = []
    var moves: [Item]     = []
    var abilities: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let plistParser = Parser<Plist>()
        plistParser.delegate = self

        self.resource = .type
        plistParser.parse(resource: .type)

        self.resource = .additionEffect
        plistParser.parse(resource: .additionEffect)

        self.resource = .moveCategory
        plistParser.parse(resource: .moveCategory)

        self.resource = .move
        plistParser.parse(resource: .move)
    }

    func parse() {
        let plistParser = Parser<Plist>()
        plistParser.delegate = self

        self.resource = .pokemon
        plistParser.parse(resource: .pokemon)

        self.resource = .ability
        plistParser.parse(resource: .ability)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ParserDelegate {
    func didLoad(items: [Item]) {
        switch self.resource {
        case .move: self.loadedMoves(items: items)
        case .type: self.loadedTypes(items: items)
        case .additionEffect: self.loadedAdditionEffects(items: items)
        case .moveCategory:   self.loadedMoveCategories(items: items)
        default: break
        }
    }

    func loadedMoves(items: [Item]) {
        let moves = items.enumerated().map { (index, item) -> Move in
            Move(move: item)
        }
        Move.repository.add(moves)
    }

    func loadedTypes(items: [Item]) {
        let types = items.map { type -> Type in
            Type(type: type)
        }
        Type.repository.add(types)
    }

    func loadedAdditionEffects(items: [Item]) {
        let additionEffects = items.map { additionEffect -> AdditionEffect in
            AdditionEffect(additionEffect: additionEffect)
        }
        AdditionEffect.repository.add(additionEffects)
    }

    func loadedMoveCategories(items: [Item]) {
        let moveCategories = items.map { moveCategory -> MoveCategory in
            MoveCategory(moveCategory: moveCategory)
        }
        MoveCategory.repository.add(moveCategories)
    }
}

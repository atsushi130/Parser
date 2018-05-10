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

        self.resource = .ability
        plistParser.parse(resource: .ability)

        self.resource = .type
        plistParser.parse(resource: .type)

        self.resource = .additionEffect
        plistParser.parse(resource: .additionEffect)

        self.resource = .moveCategory
        plistParser.parse(resource: .moveCategory)

        self.resource = .moveTarget
        plistParser.parse(resource: .moveTarget)

        self.resource = .move
        plistParser.parse(resource: .move)

        self.resource = .pokemon
        plistParser.parse(resource: .pokemon)
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
        case .pokemon:  self.loadedPokemons(items: items)
        case .move: self.loadedMoves(items: items)
        case .type: self.loadedTypes(items: items)
        case .additionEffect: self.loadedAdditionEffects(items: items)
        case .moveCategory:   self.loadedMoveCategories(items: items)
        case .moveTarget:     self.loadedMoveTargets(items: items)
        case .ability:        self.loadedAbilities(items: items)
        default: break
        }
    }
    
    func loadedPokemons(items: [Item]) {
        let pokemons = items.map { pokemon -> Pokedex in
            Pokedex(pokemon: pokemon)
        }
        Pokedex.repository.add(pokemons)
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

    func loadedAbilities(items: [Item]) {
        let abilities = items.map { ability -> Ability in
            Ability(ability: ability)
        }
        Ability.repository.add(abilities)
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

    func loadedMoveTargets(items: [Item]) {
        let moveTargets = items.map { moveTarget -> MoveTarget in
            MoveTarget(moveTarget: moveTarget)
        }
        MoveTarget.repository.add(moveTargets)
    }
}

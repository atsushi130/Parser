//
//  ViewController.swift
//  Pokemon
//
//  Created by Atsushi Miyake on 2018/05/05.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

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
        case .pokemon: self.loadedPokemons(items: items)
        case .move:    break
        case .ability: self.loadedAbilities(items: items)
        }
    }

    func loadedPokemons(items: [Item]) {
        self.pokemons = items
    }

    func loadedAbilities(items: [Item]) {

        self.abilities = items

        let pokemons = self.pokemons.map { pokemon -> Item in
            var pokemon = pokemon
            guard let abilities = pokemon["abilitys"] as? [String] else { return pokemon }
            pokemon["abilitys"] = abilities.map { pokemonAbility -> [String: String] in
                guard let ability = self.getAbility(name: pokemonAbility),
                      let id = ability["id"] as? String else { return ["name": pokemonAbility] }
                return ["name": pokemonAbility, "id": id]
            }

            return pokemon
        }

        func createPlist(items: [Item]) {

            let manager = FileManager.default
            let documentDir = manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documentDir.appendingPathComponent("gen_pokemons.plist")

            if let items = items as? NSArray {
                print(documentDir)
                items.write(to: url, atomically: true)
            }
        }

        createPlist(items: pokemons)
    }

    func getAbility(name: String) -> Item? {
        return self.abilities.filter { ability in
            guard let abilityName = ability["name"] as? String else { return false }
            return name == abilityName
        }.first
    }
}

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

    var pokemons: [Item] = []
    var moves: [Item]    = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let plistParser = Parser<Plist>()
        plistParser.delegate = self

        self.resource = .pokemon
        plistParser.parse(resource: .pokemon)

        self.resource = .move
        plistParser.parse(resource: .move)
        // plistParser.parse(resource: .ability)
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
        case .move: self.loadedMoves(items: items)
        case .ability: break
        }
    }

    func loadedPokemons(items: [Item]) {
        self.pokemons = items
    }

    func loadedMoves(items: [Item]) {

        self.moves = items

        let pokemons = self.pokemons.map { pokemon -> Item in
            var pokemon = pokemon
            guard let moves = pokemon["moves"] as? [[String: Any]] else { return pokemon }
            pokemon["moves"] = moves.map { pokemonMove -> Item in
                var learnedMove = pokemonMove
                guard let name = pokemonMove["name"] as? String,
                      let move = self.getMove(name: name),
                      let id = move["id"] as? String else { return pokemonMove }

                learnedMove["id"] = id
                return learnedMove
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

    func getMove(name: String) -> Item? {
        return self.moves.filter { move in
            guard let moveName = move["name"] as? String else { return false }
            return name == moveName
        }.first
    }
}

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

        let moves = items.enumerated().map { (index, item) -> Move in
            Move(move: item)
        }

        Move.repository.add(moves)
    }
}

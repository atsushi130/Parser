//
//  Pokedex.swift
//  Data
//
//  Created by Atsushi Miyake on 2018/05/07.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit
import Gifu

public final class Pokedex: Object {
    
    @objc public dynamic var id = 0
    @objc public dynamic var name = ""
    public var types = List<Type>()
    public var moves = List<Move>()
    public var abilities = List<Ability>()
    @objc private dynamic var frontImageData: Data!
    @objc private dynamic var backImageData: Data!
    @objc private dynamic var hp        = 0.0
    @objc private dynamic var attack    = 0
    @objc private dynamic var defence   = 0
    @objc private dynamic var spAttack  = 0
    @objc private dynamic var spDefence = 0
    @objc private dynamic var speed     = 0
    @objc private dynamic var height = 0
    @objc private dynamic var weight = 0
    @objc public dynamic var exp = 0
    private let evolutionLevel = RealmOptional<Int>()
    @objc private var evolutionMethod: String? = nil
    private let evolutionPokemonId = RealmOptional<Int>()

    public var baseStatus: PokemonStatus {
        return PokemonStatus(attack: self.attack, defence: self.defence, spAttack: self.spAttack, spDefence: self.spDefence, speed: self.speed, hp: self.hp)
    }
    
    public var evolutionPokemon: Evolution? {
        return Evolution(level: self.evolutionLevel.value, method: self.evolutionMethod, pokemonId: self.evolutionPokemonId.value)
    }

    public var body: PokemonBody {
        return PokemonBody(weight: self.weight, height: self.height)
    }
    
    public var frontImageView: GIFImageView {
        return GIFImageView(data: self.frontImageData)
    }

    public convenience init(pokemon: [String: Any]) {
        self.init()
        
        self.id = Int((pokemon["id"] as! String).replacingOccurrences(of:" ", with:""))!
        self.name = pokemon["name"] as! String
        print("ID: \(id)")

        self.hp        = pokemon["HP"] as! Double
        self.attack    = pokemon["atk"] as! Int
        self.defence   = pokemon["def"] as! Int
        self.spAttack  = pokemon["sp_atk"] as! Int
        self.spDefence = pokemon["sp_def"] as! Int
        self.speed     = pokemon["spd"] as! Int
        self.exp       = pokemon["exp"] as! Int
        self.height    = Int(pokemon["height"] as! String)!
        self.weight    = Int(pokemon["weight"] as! String)!
        
        let evolution = pokemon["evolution"] as? [String: Any]
        self.evolutionLevel.value = evolution?["level"] as? Int
        self.evolutionMethod = evolution?["method"] as? String
        if let evolutionPokemonName = evolution?["to"] as? String {
            self.evolutionPokemonId.value = Pokedex.repository.findBy(name: evolutionPokemonName)?.id
        }

        let frontImageName = pokemon["english_name"] as! String
        let backImageName  = pokemon["english_name"] as! String + "-back"
        let bundlePath = Bundle.main.path(forResource: "images", ofType: ".bundle")!
        let frontPath  = Bundle(path: bundlePath)!.path(forResource: "frontSpite/\(frontImageName)", ofType: ".gif")
        let backPath   = Bundle(path: bundlePath)!.path(forResource: "backSplite/\(backImageName)", ofType: ".gif")
        let frontUrl = URL(fileURLWithPath: frontPath!)
        let backUrl  = URL(fileURLWithPath: backPath!)
        self.frontImageData = try! Data(contentsOf: frontUrl)
        self.backImageData  = try! Data(contentsOf: backUrl)

        let types = pokemon["types"] as! [String]
        types.forEach { type in
            let type = Type.repository.findBy(name: type)!
            self.types.append(type)
        }

        let moves = pokemon["moves"] as! [[String: Any]]
        moves.enumerated()
            .map { index, move -> String in
                move["name"] as! String
            }
            .forEach { name in
                var searchName = name
                if name == "はたきおちす" {
                    searchName = "はたきおとす"
                } else if name == "とうせんぼう" {
                    searchName = "とおせんぼう"
                } else if name == "やきつくつ" {
                    searchName = "やきつくす"
                } else if name == "あにび" {
                    searchName = "おにび"
                } else if name == "ドリルランナー" {
                    searchName = "ドリルライナー"
                } else if name == "あいうち" {
                    searchName = "おいうち"
                } else if name == "ブレイズクロー" {
                    searchName = "ブレイククロー"
                } else if name == "スイーブビンタ" {
                    searchName = "スイープビンタ"
                } else if name == "あきみやげ" {
                    searchName = "おきみやげ"
                } else if name == "えんじふゆう" {
                    searchName = "でんじふゆう"
                } else if name == "つあらおとし" {
                    searchName = "つららおとし"
                } else if name == "みちずれ" {
                    searchName = "みちづれ"
                } else if name == "ミラーダイブ" {
                    searchName = "ミラータイプ"
                } else if name == "かいふくしてい" {
                    searchName = "かいふくしれい"
                } else if name == "にぎりつぶる" {
                    searchName = "にぎりつぶす"
                } else if name == "しんぷのつるぎ" {
                    searchName = "しんぴのつるぎ"
                }

                let move = Move.repository.findBy(name: searchName)!
                self.moves.append(move)
            }

        let abilities = pokemon["abilitys"] as! [[String: String]]
        abilities.forEach { abilityDictionary in
            let name = abilityDictionary["name"]!.replacingOccurrences(of:" ", with:"")
            let ability = Ability.repository.findBy(name: name)!
            self.abilities.append(ability)
        }
    }
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    public static var repository: Repository<Pokedex> {
        return Repository<Pokedex>()
    }
}

extension GIFImageView {
    convenience init(data: Data) {
        let image = UIImage(data: data)
        self.init(image: image)
        self.animate(withGIFData: data)
    }
}

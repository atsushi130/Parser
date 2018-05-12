//
//  Evolution.swift
//  Data
//
//  Created by Atsushi Miyake on 2018/05/12.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation

public struct Evolution {
    let level: Int?
    let method: EvolutionMethod?
    let pokemonId: Int
    init?(level: Int?, method: String?, pokemonId: Int?) {
        guard let pokemonId = pokemonId else { return nil }
        self.level     = level
        self.method    = EvolutionMethod(rawValue: method ?? "")
        self.pokemonId = pokemonId
    }
}

enum EvolutionMethod: String {
    case levelUp = "level_up"
    case other   = "other"
}


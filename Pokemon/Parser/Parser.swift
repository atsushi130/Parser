//
// Created by Atsushi Miyake on 2018/05/05.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation

protocol ParserDelegate {
    func didLoad(items: [Item])
}

typealias Item = [String: Any]
final class Parser<T: Parseable>: NSObject {

    var delegate: ParserDelegate? = nil

    func parse(resource: Resource) {
        let parseResource = T()
        parseResource.load(resource: resource) { [weak self] items in
            self?.delegate?.didLoad(items: items)
        }
    }
}

enum Resource: String {

    case pokemon
    case move
    case ability
    case type
    case additionEffect
    case moveCategory
    case moveTarget

    var name: String {
        switch self {
        case .pokemon:        return "pokemons"
        case .move:           return "moves"
        case .ability:        return "abilities"
        case .type:           return "types"
        case .additionEffect: return "additionEffects"
        case .moveCategory:   return "moveCategories"
        case .moveTarget:     return "moveTargets"
        }
    }

    func isElement(tag: String) -> Bool {
        return self.rawValue == tag
    }

    func validate(tag: String) -> Bool {
        return self.name != tag
    }
}

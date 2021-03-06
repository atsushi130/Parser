//
//  PokedexRepository.swift
//  Data
//
//  Created by Atsushi Miyake on 2018/05/07.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation

extension Repository where ObjectType: Pokedex {
    
    public static var repository: Repository<ObjectType> {
        return Repository<ObjectType>()
    }
    
    public func findBy(name: String) -> ObjectType? {
        let codePredicate = NSPredicate(format: "name == %@", name)
        return Repository<ObjectType>.repository.findAll(predicate: codePredicate).first
    }
}

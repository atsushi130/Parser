//
// Created by Atsushi Miyake on 2018/05/06.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation

extension Repository where ObjectType: Move {
    public static var repository: Repository<ObjectType> {
        return Repository<ObjectType>()
    }
}
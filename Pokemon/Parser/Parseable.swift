//
// Created by Atsushi Miyake on 2018/05/05.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation

protocol Parseable {
    init()
    func load(resource: Resource, completionHandler: @escaping ([Item]) -> Void)
}

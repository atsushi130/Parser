//
// Created by Atsushi Miyake on 2018/05/05.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation

struct Plist: ParseResource {

    func load(resource: Resource, completionHandler: @escaping ([Item]) -> Void) {
        guard let path = Bundle.main.path(forResource: resource.name, ofType: ".plist"),
              let items = NSArray(contentsOfFile: path) as? [Item] else {
            completionHandler([])
            return
        }

        completionHandler(items)
    }
}
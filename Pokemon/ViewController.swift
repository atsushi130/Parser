//
//  ViewController.swift
//  Pokemon
//
//  Created by Atsushi Miyake on 2018/05/05.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let parser = Parser<Plist>()
        parser.delegate = self
        parser.parse(resource: .pokemon)
        parser.parse(resource: .move)
        parser.parse(resource: .ability)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ParserDelegate {
    func didLoad(items: [Item]) {
        print(items)
    }
}

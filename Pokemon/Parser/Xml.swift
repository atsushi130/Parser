//
// Created by Atsushi Miyake on 2018/05/05.
// Copyright (c) 2018 Atsushi Miyake. All rights reserved.
//

import Foundation

final class Xml: NSObject, Parseable {

    var item: Item    = [:]
    var items: [Item] = []
    var tag: String? = nil
    var resource: Resource = .move
    var didLoad: (([Item]) -> Void)? = nil

    override init() {
    }

    func load(resource: Resource, completionHandler: @escaping ([Item]) -> Void) {

        self.initItem()
        self.resource = resource
        self.didLoad = completionHandler

        guard let url = Bundle.main.url(forResource: self.resource.name, withExtension: "xml"),
              let parser = XMLParser(contentsOf: url) else { return }

        parser.delegate = self
        parser.parse()
    }

    func initItem() {
        self.items = []
        self.item  = [:]
    }

    func createPlist() {

        let manager = FileManager.default
        let documentDir = manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentDir.appendingPathComponent("\(self.resource.name).plist")

        if let items = self.items as? NSArray {
            print(documentDir)
            items.write(to: url, atomically: true)
        }
    }
}

extension Xml: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        self.tag = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {

        guard let tag = self.tag, self.resource.validate(tag: tag) else { return }

        if self.resource.isElement(tag: tag) {

            if self.item.isEmpty { return }

            if self.resource == .ability {
                let id = "\(self.items.count + 1)"
                self.item["id"] = id
            }

            self.items.append(self.item)
            self.item = [:]
            return
        }

        self.item[tag] = string
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.tag = nil
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        self.didLoad?(self.items)
    }
}

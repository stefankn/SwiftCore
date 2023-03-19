//
//  XMLReaderParserDelegate.swift
//  X10Core
//
//  Created by Stefan Klein Nulent on 01/09/2020.
//  Copyright © 2020 Extendas. All rights reserved.
//

import Foundation

extension XMLReader {
    
    class ParserDelegate: NSObject, XMLParserDelegate {
        
        // MARK: - Properties
        
        var elements: [XMLElement] = []
        
        
        
        // MARK: - Functions
        
        // MARK: XMLParserDelegate Functions
        
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            let attributes = attributeDict.reduce(into: [:]) { $0[XMLElement.AttributeName(rawValue: $1.key)] = $1.value }
            elements.append(XMLElement(XMLElement.TagName(rawValue: elementName), attributes: attributes))
        }
        
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
            if !value.isEmpty, var element = elements.popLast() {
                element.children.append(.text(value))
                elements.append(element)
            }
        }
        
        func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
            elements.removeAll()
        }
        
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            let childElement = elements.popLast()
            let parentElement = elements.popLast()
            
            if var parentElement = parentElement, let childElement = childElement {
                parentElement.children.append(.element(childElement))
                elements.append(parentElement)
            } else if let childElement = childElement {
                elements.append(childElement)
            }
        }
    }
}

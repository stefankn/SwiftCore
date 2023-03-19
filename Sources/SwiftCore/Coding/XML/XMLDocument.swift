//
//  XMLDocument.swift
//  X10Core
//
//  Created by Stefan Klein Nulent on 01/09/2020.
//  Copyright © 2020 Extendas. All rights reserved.
//

import Foundation

public struct XMLDocument {
    
    // MARK: - Properties
    
    public let rootElement: XMLElement
    public let version: String
    public let characterEncoding: String
    
    
    
    // MARK: - Construction
    
    public init(rootElement: XMLElement, version: String = "1.0", characterEncoding: String = "UTF-8") {
        self.rootElement = rootElement
        self.version = version
        self.characterEncoding = characterEncoding
    }
    
    
    
    // MARK: - Functions
    
    public func firstChild(by tagName: XMLElement.TagName) -> XMLElement? {
        rootElement.firstChild(by: tagName)
    }
    
    public func firstText(by tagName: XMLElement.TagName) -> String? {
        firstChild(by: tagName)?.text
    }
}

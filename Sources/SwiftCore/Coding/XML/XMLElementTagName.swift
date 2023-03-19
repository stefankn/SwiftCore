//
//  XMLElementTagName.swift
//  X10Core
//
//  Created by Stefan Klein Nulent on 02/09/2020.
//  Copyright © 2020 Extendas. All rights reserved.
//

import Foundation

extension XMLElement {
    
    public struct TagName: RawRepresentable, ExpressibleByStringLiteral {
        
        // MARK: - Properties
        
        public let rawValue: String
        
        
        
        // MARK: - Construction
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        
        // MARK: ExpressibleByStringLiteral Construction
        
        public init(stringLiteral value: String) {
            self.init(rawValue: value)
        }
    }
}

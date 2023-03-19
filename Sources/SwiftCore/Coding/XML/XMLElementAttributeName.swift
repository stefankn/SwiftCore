//
//  XMLElementAttributeName.swift
//  
//
//  Created by Stefan Klein Nulent on 18/03/2023.
//

import Foundation

extension XMLElement {
    
    public struct AttributeName: RawRepresentable, ExpressibleByStringLiteral, Hashable {
        
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

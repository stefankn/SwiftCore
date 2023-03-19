//
//  XMLReader.swift
//  X10Core
//
//  Created by Stefan Klein Nulent on 01/09/2020.
//  Copyright © 2020 Extendas. All rights reserved.
//

import Foundation

public class XMLReader {
    
    // MARK: - Types
    
    public enum XMLError: Error, CustomStringConvertible {
        case invalidData
        case parsingFailed(lineNumber: Int, columnNumber: Int)
        
        
        
        // MARK: - Properties
        
        // MARK: CustomStringConvertible Properties
        
        public var description: String {
            switch self {
            case .parsingFailed(let lineNumber, let columnNumber):
                return "Failed to parse XML at line \(lineNumber), column: \(columnNumber)"
            case .invalidData:
                return "Could not parse data"
            }
        }
    }
    
    
    
    // MARK: - Private Properties
    
    private let parserDelegate = ParserDelegate()
    
    
    
    // MARK: - Construction
    
    public init() {}
    
    
    
    // MARK: - Functions
    
    public func parse(_ string: String) throws -> XMLDocument {
        if let data = string.data(using: .utf8) {
            return try parse(data)
        } else {
            throw XMLError.invalidData
        }
    }
    
    public func parse(_ data: Data) throws -> XMLDocument {
        let parser = XMLParser(data: data)
        parser.delegate = parserDelegate
        
        if parser.parse(), let element = parserDelegate.elements.popLast() {
            return XMLDocument(rootElement: element)
        } else {
            throw XMLError.parsingFailed(lineNumber: parser.lineNumber, columnNumber: parser.columnNumber)
        }
    }
}

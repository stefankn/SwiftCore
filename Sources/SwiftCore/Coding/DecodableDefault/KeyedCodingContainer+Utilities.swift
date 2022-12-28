//
//  KeyedDecodingContainer+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 27/12/2022.
//

import Foundation

extension KeyedDecodingContainer {
    
    // MARK: - Functions
    
    public func decode<T>(_ type: DecodableDefault.Wrapper<T>.Type, forKey key: Key) throws -> DecodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

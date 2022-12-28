//
//  DecodableDefaultWrapper.swift
//  
//
//  Created by Stefan Klein Nulent on 27/12/2022.
//

import Foundation

extension DecodableDefault {
    
    @propertyWrapper
    public struct Wrapper<Source: DecodableDefaultSource> {
        
        // MARK: - Types
        
        public typealias Value = Source.Value
        
        
        
        // MARK: - Properties
        
        public var wrappedValue = Source.defaultValue
        
        
        public init(wrappedValue: Value = Source.defaultValue) {
            self.wrappedValue = wrappedValue
        }
    }
}

extension DecodableDefault.Wrapper: Decodable {
    
    // MARK: - Construction
    
    // MARK: Decodable Construction
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Value.self)
    }
}

extension DecodableDefault.Wrapper: Encodable where Value: Encodable {
    
    // MARK: - Functions
    
    // MARK: Encodable Functions
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension DecodableDefault.Wrapper: Equatable where Value: Equatable {}
extension DecodableDefault.Wrapper: Hashable where Value: Hashable {}

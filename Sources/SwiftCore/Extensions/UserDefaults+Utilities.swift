//
//  UserDefaults+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 19/01/2023.
//

import Foundation

extension UserDefaults {
    public struct Key: RawRepresentable, ExpressibleByStringLiteral {
        
        // MARK: - Properties
        
        public var rawValue: String
        
        
        
        // MARK: - Construction
        
        // MARK: RawRepresentable Construction
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        
        // MARK: ExpressibleByStringLiteral Construction
        
        public init(stringLiteral value: StringLiteralType) {
            self.init(rawValue: value)
        }
    }
}

extension UserDefaults {
    
    // MARK: - Functions
    
    public func contains(_ key: Key) -> Bool {
        object(forKey: key.rawValue) != nil
    }
    
    public func string(for key: Key) -> String? {
        string(forKey: key.rawValue)
    }
    
    public func data(for key: Key) -> Data? {
        data(forKey: key.rawValue)
    }
    
    public func date(for key: Key) -> Date? {
        if let string = string(for: key) {
            return ISO8601DateFormatter().date(from: string)
        } else {
            return nil
        }
    }
    
    public func set(_ string: String?, for key: Key) {
        if let string = string {
            set(string, forKey: key.rawValue)
        } else {
            remove(for: key)
        }
    }
    
    public func set(_ data: Data?, for key: Key) {
        if let data = data {
            set(data, forKey: key.rawValue)
        } else {
            remove(for: key)
        }
    }
    
    public func set(_ date: Date?, for key: Key) {
        if let date = date {
            set(ISO8601DateFormatter().string(from: date), for: key)
        } else {
            remove(for: key)
        }
    }
    
    public func remove(for key: Key) {
        removeObject(forKey: key.rawValue)
    }
}

//
//  DecodableDefaultSource.swift
//  
//
//  Created by Stefan Klein Nulent on 27/12/2022.
//

import Foundation

public protocol DecodableDefaultSource {
    
    // MARK: - Types
    
    associatedtype Value: Decodable
    
    
    
    // MARK: - Constants
    
    static var defaultValue: Value { get }
}

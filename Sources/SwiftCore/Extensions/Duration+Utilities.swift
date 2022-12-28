//
//  Duration+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 11/12/2022.
//

import Foundation

extension Duration {
    
    // MARK: - Properties
    
    public var nanoseconds: Int64 {
        components.seconds * 1_000_000_000 + components.attoseconds / 1_000_000_000
    }
    
    public var microseconds: Int64 {
        nanoseconds / 1000
    }
    
    public var milliseconds: Int64 {
        microseconds / 1000
    }
    
    public var seconds: TimeInterval {
        TimeInterval(Double(milliseconds) / 1000)
    }
}

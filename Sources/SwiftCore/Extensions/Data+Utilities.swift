//
//  Data+Utilities.swift
//  Maeve
//
//  Created by Stefan Klein Nulent on 22/11/2023.
//

import Foundation

extension Data {
    
    // MARK: - Functions
    
    mutating func append(_ string: String, encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

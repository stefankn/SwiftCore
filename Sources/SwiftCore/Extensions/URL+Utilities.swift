//
//  URL+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 11/12/2022.
//

import Foundation

extension URL {
    
    // MARK: - Construction
    
    public init?(_ string: String?) {
        if let string = string, let url = URL(string: string) {
            self = url
        } else {
            return nil
        }
    }
}

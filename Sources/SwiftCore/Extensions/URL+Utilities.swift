//
//  URL+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 11/12/2022.
//

import Foundation
import UniformTypeIdentifiers

extension URL {
    
    // MARK: - Construction
    
    public init?(_ string: String?) {
        if let string = string, let url = URL(string: string) {
            self = url
        } else {
            return nil
        }
    }
    
    
    
    // MARK: - Properties
    
    public var mimeType: String? {
        if !pathExtension.isEmpty, let mimeType = UTType(filenameExtension: pathExtension)?.preferredMIMEType {
            return mimeType
        } else {
            return nil
        }
    }
}

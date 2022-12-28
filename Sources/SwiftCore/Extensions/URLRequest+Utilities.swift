//
//  URLRequest+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 11/12/2022.
//

import Foundation

extension URLRequest {
    
    // MARK: - Types
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    
    
    // MARK: - Construction
    
    public init(method: Method, url: URL) {
        self.init(url: url)
        httpMethod = method.rawValue
    }
}

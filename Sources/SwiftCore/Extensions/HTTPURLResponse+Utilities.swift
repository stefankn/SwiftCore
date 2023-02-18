//
//  HTTPURLResponse+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 18/02/2023.
//

import Foundation

extension HTTPURLResponse {
    
    // MARK: - Properties
    
    public var status : HTTPStatus {
        HTTPStatus(statusCode)
    }
}

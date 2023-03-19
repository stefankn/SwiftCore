//
//  Publisher+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 18/03/2023.
//

import Foundation
import Combine

extension Publisher where Failure == Never {
    
    // MARK: - Functions
    
    public func assignWeak<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
        sink { [weak root] in
            root?[keyPath: keyPath] = $0
        }
    }
}

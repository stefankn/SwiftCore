//
//  NSPredicate+Utilities.swift
//
//
//  Created by Stefan Klein Nulent on 21/01/2024.
//

import Foundation

extension NSPredicate {
    
    // MARK: - Functions
    
    public static func or(_ predicates: [NSPredicate?]) -> NSPredicate {
        NSCompoundPredicate(orPredicateWithSubpredicates: predicates.compactMap{ $0 })
    }
    
    public static func or(_ predicates: NSPredicate?...) -> NSPredicate {
        or(predicates)
    }
    
    public static func and(_ predicates: [NSPredicate?]) -> NSPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: predicates.compactMap{ $0 })
    }
    
    public static func and(_ predicates: NSPredicate?...) -> NSPredicate {
        and(predicates)
    }
    
    public static func isEqual(_ property: String, to value: String) -> NSPredicate {
        NSPredicate(format: "\(property) == %@", value)
    }
    
    public static func isEqual(_ property: String, to value: Int) -> NSPredicate {
        NSPredicate(format: "\(property) == %d", value)
    }
    
    public static func isEqual(_ property: String, to value: Bool) -> NSPredicate {
        NSPredicate(format: "\(property) == %@", NSNumber(value: value))
    }
    
    public static func isTrue(_ property: String) -> NSPredicate {
        NSPredicate(format: "\(property) == true")
    }
    
    public static func isFalse(_ property: String) -> NSPredicate {
        NSPredicate(format: "\(property) == false")
    }
    
    public static func isNil(_ property: String) -> NSPredicate {
        NSPredicate(format: "\(property) == nil")
    }
    
    public static func isNotNil(_ property: String) -> NSPredicate {
        NSPredicate(format: "\(property) != nil")
    }
    
    public static func contains(_ property: String, value: String, caseInsensitive: Bool = true) -> NSPredicate {
        let contains = caseInsensitive ? "contains[cd]" : "contains"
        return NSPredicate(format: "\(property) \(contains) %@", value)
    }
}

//
//  DecodableDefault.swift
//  
//
//  Created by Stefan Klein Nulent on 27/12/2022.
//

import Foundation

/// Enum is used here as a namespace
public enum DecodableDefault {
    
    // MARK: - Types
    
    public typealias Source = DecodableDefaultSource
    public typealias List = Decodable & ExpressibleByArrayLiteral
    public typealias Map = Decodable & ExpressibleByDictionaryLiteral
    
    public typealias True = Wrapper<Sources.True>
    public typealias False = Wrapper<Sources.False>
    public typealias EmptyString = Wrapper<Sources.EmptyString>
    public typealias EmptyList<T: List> = Wrapper<Sources.EmptyList<T>>
    public typealias EmptyMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
    public typealias Zero = Wrapper<Sources.Zero>
    public typealias One = Wrapper<Sources.One>
    
    public enum Sources {
        public enum True: Source {
            public static var defaultValue: Bool { true }
        }
        
        public enum False: Source {
            public static var defaultValue: Bool { false }
        }
        
        public enum EmptyString: Source {
            public static var defaultValue: String { "" }
        }
        
        public enum EmptyList<T: List>: Source {
            public static var defaultValue: T { [] }
        }
        
        public enum EmptyMap<T: Map>: Source {
            public static var defaultValue: T { [:] }
        }
        
        public enum Zero: Source {
            public static var defaultValue: Int { 0 }
        }
        
        public enum One: Source {
            public static var defaultValue: Int { 1 }
        }
    }
}



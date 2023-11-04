//
//  Keychain.swift
//  
//
//  Created by Stefan Klein Nulent on 27/01/2023.
//

import Foundation

public class Keychain {
    
    // MARK: - Constants
    
    static let defaultServiceName: String = { Bundle.main.bundleIdentifier ?? "Keychain" }()
    
    
    
    // MARK: - Properties
    
    /// Unique identifier for all keys stored using this keychain instance.
    private(set) public var serviceName: String
    
    /// Optional access group for sharing keychain items between applications.
    private(set) public var accessGroup: String?
    
    
    
    // MARK: - Construction
    
    /// Create an instance of the keychain with a custom service name and optional access group.
    ///
    /// - parameter serviceName: Unique identifier for all keys stored using this keychain instance.
    /// - parameter accessGroup: Optional identifier for sharing keychain items between applications.
    ///
    public init(serviceName: String, accessGroup: String? = nil) {
        self.serviceName = serviceName
        self.accessGroup = accessGroup
    }
    
    /// Create an default instance of the keychain.
    ///
    public convenience init() {
        self.init(serviceName: Self.defaultServiceName)
    }
    
    
    
    // MARK: - Functions
    
    /// Checks if an entry exists for the specified key.
    ///
    /// - parameter key: The key to check.
    /// - returns: True if an entry exists for the specified key, else false.
    ///
    public func hasValue(for key: String) -> Bool {
        data(for: key) != nil
    }
    
    /// Retrieves an integer for the specified key.
    ///
    /// - parameter key: The key to lookup data for.
    /// - returns: The integer associated with the specified key, nil if no data exists.
    ///
    public func int(for key: String) -> Int? {
        (object(for: key) as? NSNumber)?.intValue
    }
    
    /// Retrieves a float for the specified key.
    ///
    /// - parameter key: The key to lookup data for.
    /// - returns: The float associated with the specified key, nil if no data exists.
    ///
    public func float(for key: String) -> Float? {
        (object(for: key) as? NSNumber)?.floatValue
    }
    
    /// Retrieves a double for the specified key.
    ///
    /// - parameter key: The key to lookup data for.
    /// - returns: The double associated with the specified key, nil if no data exists.
    ///
    public func double(for key: String) -> Double? {
        (object(for: key) as? NSNumber)?.doubleValue
    }
    
    /// Retrieves a boolean for the specified key.
    ///
    /// - parameter key: The key to lookup data for.
    /// - returns: The boolean associated with the specified key, nil if no data exists.
    ///
    public func bool(for key: String) -> Bool? {
        (object(for: key) as? NSNumber)?.boolValue
    }
    
    /// Retrieves a string for the specified key.
    ///
    /// - parameter key: The key to lookup data for.
    /// - returns: The string associated with the specified key, nil if no data exists.
    ///
    public func string(for key: String) -> String? {
        if let data = data(for: key) {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
    
    
    /// Retrieves data for the specified key.
    ///
    /// - parameter key: The key to lookup data for.
    /// - returns: The data associated with the specified key, nil if no data exists.
    ///
    public func data(for key: String) -> Data? {
        var queryDictionary = queryDictionary(for: key)
        queryDictionary[kSecMatchLimit as String] = kSecMatchLimitOne
        queryDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = SecItemCopyMatching(queryDictionary as CFDictionary, &result)
        
        return status == noErr ? result as? Data : nil
    }
    
    /// Retrieves an object conforming to NSCoding for the specified key.
    ///
    /// - parameter key: The key to lookup data for.
    /// - returns: The object associated with the specified key, nil if no data exists.
    ///
    public func object(for key: String) -> NSCoding? {
        if let data = data(for: key) {
            return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSCoding
        } else {
            return nil
        }
    }
    
    /// Store a integer to the keychain for the specified key.
    ///
    /// - parameter data: The data to store.
    /// - parameter key: The key under which to store the data.
    /// - returns: true if storing was successful, else false
    ///
    public func set(_ value: Int, for key: String) -> Bool {
        set(NSNumber(value: value), for: key)
    }
    
    /// Store a float to the keychain for the specified key.
    ///
    /// - parameter data: The data to store.
    /// - parameter key: The key under which to store the data.
    /// - returns: true if storing was successful, else false
    ///
    public func set(_ value: Float, for key: String) -> Bool {
        set(NSNumber(value: value), for: key)
    }
    
    /// Store a double to the keychain for the specified key.
    ///
    /// - parameter data: The data to store.
    /// - parameter key: The key under which to store the data.
    /// - returns: true if storing was successful, else false
    ///
    public func set(_ value: Double, for key: String) -> Bool {
        set(NSNumber(value: value), for: key)
    }
    
    /// Store a boolean to the keychain for the specified key.
    ///
    /// - parameter data: The data to store.
    /// - parameter key: The key under which to store the data.
    /// - returns: true if storing was successful, else false
    ///
    public func set(_ value: Bool, for key: String) -> Bool {
        set(NSNumber(value: value), for: key)
    }
    
    /// Store a string to the keychain for the specified key.
    ///
    /// - parameter data: The data to store.
    /// - parameter key: The key under which to store the data.
    /// - returns: true if storing was successful, else false
    ///
    @discardableResult
    public func set(_ value: String, for key: String) -> Bool {
        if let data = value.data(using: .utf8) {
            return set(data, for: key)
        } else {
            return false
        }
    }
    
    /// Store an object conforming to NSCoding to the keychain for the specified key.
    ///
    /// - parameter data: The data to store.
    /// - parameter key: The key under which to store the data.
    /// - returns: true if storing was successful, else false
    ///
    public func set(_ object: NSCoding, for key: String) -> Bool {
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false) {
            return set(data, for: key)
        } else {
            return false
        }
    }
    
    /// Store data to the keychain for the specified key.
    ///
    /// - parameter data: The data to store.
    /// - parameter key: The key under which to store the data.
    /// - returns: true if storing was successful, else false
    ///
    @discardableResult
    public func set(_ data: Data, for key: String) -> Bool {
        var queryDictionary = queryDictionary(for: key)
        queryDictionary[kSecValueData as String] = data
        queryDictionary[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlocked
        
        let status = SecItemAdd(queryDictionary as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            return update(data, for: key)
        } else {
            return status == errSecSuccess
        }
    }
    
    /// Remove an entry from the keychain for the specified key.
    ///
    /// - parameter key: The key for which to remove the entry.
    /// - returns: true if successful, else false
    ///
    public func remove(for key: String) -> Bool {
        SecItemDelete(queryDictionary(for: key) as CFDictionary) == errSecSuccess
    }
    
    /// Removes all keychain data for the service name and access group if set.
    public func removeAll() -> Bool {
        var dictionary: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName
        ]
        
        if let accessGroup = accessGroup {
            dictionary[kSecAttrAccessGroup as String] = accessGroup
        }
        
        return SecItemDelete(dictionary as CFDictionary) == errSecSuccess
    }
    
    
    
    // MARK: - Private Functions
    
    private func queryDictionary(for key: String) -> [String: Any] {
        let key = key.data(using: .utf8) ?? Data()
        
        var dictionary: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrGeneric as String: key,
            kSecAttrAccount as String: key
        ]
        
        if let accessGroup = accessGroup {
            dictionary[kSecAttrAccessGroup as String] = accessGroup
        }
        
        return dictionary
    }
    
    private func update(_ data: Data, for key: String) -> Bool {
        SecItemUpdate(queryDictionary(for: key) as CFDictionary, [kSecValueData: data] as CFDictionary) == errSecSuccess
    }
}

//
//  UserSettingsUtil.swift v.0.1.0
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 22.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import Foundation
/**
 Usage examples

     // declare a struct to be saved to / restored from UserDefaults
     struct Language: Codable, Equatable {
        var name: String
        var version: String
     }

     let defaults = UserDefaults.standard
     let languageKey = "defaultLanguage"

     // create an instance
     let testLanguage = Language(name: "Swift", version: "4")

     // save in defaults
     defaults.set(value: testLanguage, forKey: languageKey)

     // restore from defaults should succeed
     if let language: Language = defaults.get(forKey: languageKey) {
        // use the value found in defaults
     } else {
        // did not find it in defaults
     }

     // remove from defaults
     defaults.remove(forKey: languageKey)

     // restore from defaults should fail
     if let language: Language = defaults.get(forKey: languageKey) {
        // it won't get here after we removed the value from defaults
     }

 */

/// methods for saving / restoring arbitrary struct in defaults
extension UserDefaults {
    /// Encode value with JSONEncoder
    ///
    /// - Parameter value: to be encoded
    /// - Returns: Data
    /// - Throws: on error
    private func encode<AStruct: Codable>(value: AStruct) throws -> Data {
        return try JSONEncoder().encode(value)
    }

    /// Decode from data with JSONDecoder
    ///
    /// - Parameter data: to be decoded
    /// - Returns: decoded value
    /// - Throws: on error
    private func decode<AStruct: Codable>(from data: Data) throws -> AStruct {
        return try JSONDecoder().decode(AStruct.self, from: data)
    }

    /// Save the value in defaults at key
    ///
    /// - Parameters:
    ///   - value: value to be saved
    ///   - key: target key
    func set<AStruct: Codable>(value: AStruct, forKey key: String) {
        if let encoded = try? encode(value: value) {
            set(encoded, forKey: key)
        }
    }

    /// Recover a value from defaults at key
    ///
    /// - Parameter key: target key
    /// - Returns: value or nil (if not found)
    func get<AStruct: Codable>(forKey key: String) -> AStruct? {
        if let data = self.object(forKey: key) as? Data {
            if let value: AStruct = try? decode(from: data) {
                return value
            }
        }
        return nil
    }

    /// Remove a value if any at the key in defaults
    ///
    /// - Parameter key: target key
    func remove(forKey key: String) {
        removeObject(forKey: key)
    }
}

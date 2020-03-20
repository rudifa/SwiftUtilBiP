//
//  RegexUtil.swift v.0.5.0
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 28.04.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

/**
 Originally from
 https://learnappmaking.com/regular-expressions-swift-string/
 https://stackoverflow.com/questions/27880650/swift-extract-regex-matches
 */
extension String
{
    /// Returns an array of substrings in self that matched the regex pattern
    ///
    /// - Parameter regex: pattern
    /// - Returns: [String]
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    /// Check if self is blank (is empty or consists of whitespace characters only)
    ///
    /// - Returns: true if self is blank
    func isBlank() -> Bool {
        return matches(for: "^\\s*$") != []
    }

    /// Returns true if self matches the regex pattern
    ///
    /// - Parameter regex: pattern
    /// - Returns: Bool
    func doesMatch(regex: String) -> Bool {
        return matches(for: regex) != []
    }
}

extension String
{
    /// Returns UUID (if any) found in self
    ///
    /// - Returns: String that matched the UUID pattern or empty string
    /// - Example: "https://my-app/product_images%2F08D41FB1-8B2E-4F6F-977A-BFA876AEF775.png" -> "08D41FB1-8B2E-4F6F-977A-BFA876AEF775"
    func extractUUID() -> String {
        let matches = self.matches(for: "[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}")
        if matches.count > 0 {
            return matches[0]
        }
        return ""
    }
}

/**
 Originally from
 https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift
 */

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }

    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}


func ~= (lhs: String, rhs: String) -> Bool {
    guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
    let range = NSRange(location: 0, length: lhs.utf16.count)
    return regex.firstMatch(in: lhs, options: [], range: range) != nil
}

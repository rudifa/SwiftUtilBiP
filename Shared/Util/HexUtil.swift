//
//  HexUtil.swift v.0.3.1
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 15.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

extension String {
    /// Returns space-separated hex codes of unicode characters in self, like "66 6c 61 67 73 20 1f1e7 1f1f7 1f1f3 1f1ff"
    var hexDump: String {
        let arr = unicodeScalars.map {
            String(format: "%02x", $0.value)
        }
        return arr.joined(separator: " ")
    }

    func hexDump(lineSize: Int) -> String {
        let charArray = unicodeScalars.map {String(format: "%02x", $0.value)}
        let chunked = charArray.chunked(into: lineSize)
        let lines = chunked.map{$0.joined(separator: " ")}
        return lines.joined(separator: "\n")
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension Data {
    /// Returns the string representation of data
    var toString: String? {
        NSString(data: self, encoding: String.Encoding.utf8.rawValue) as String?
    }
}

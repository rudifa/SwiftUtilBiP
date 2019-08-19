//
//  HexUtil.swift v.0.1.0
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
}

//
//  HexUtil.swift v.0.1.0
//  Swift4Util
//
//  Created by Rudolf Farkas on 15.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

extension String {
    var hexDump: String {
        let arr = unicodeScalars.map {
            String(format: "%02x", $0.value)
        }
        return arr.joined(separator: " ")
    }

    var dump: String {
        let arr = unicodeScalars.map {
            String($0.value, radix: 16, uppercase: true)
        }
        return arr.joined(separator: " ")
    }

    func hexdump(step: Int = 10) {
        for i in stride(from: 0, to: count, by: step) {
            let sub = dropFirst(i).prefix(step) as Substring
            print(sub)
        }
    }

    // TODO:
    // make a hexdumper that returns an array of dump lines, with 8 chars per line, hex and unicode
    // probably should break up into characters, stride & make a dump line for each n characters

//    let aStr = String(format: "%@%x", "timeNow in hex: ", timeNow)

//    for myInt in 1...3 {
//    print(String(format: "%02d", myInt))
//    }
}

//
//  HexUtilTests.swift v.0.1.0
//  Swift4UtilTests
//
//  Created by Rudolf Farkas on 15.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import XCTest

class HexUtilTests: XCTestCase {
    func testHexDump() {
        let string = "Hello Swift\t"
        let hexdump = string.hexDump
        XCTAssertEqual(hexdump, "48 65 6c 6c 6f 20 53 77 69 66 74 09")
        printClassAndFunc(info: "\(string), \(hexdump)")
        print("---- |\(string)| |\(hexdump)|")

        let s = 4
        for i in stride(from: 0, to: string.count, by: s) {
            let sub = string.dropFirst(i).prefix(s) as Substring
            print(sub)
        }
        string.hexdump(step: 5)
    }

    func testHexDump2() {
        // https://oleb.net/blog/2017/11/swift-4-strings/
        let string = "flags 🇧🇷🇳🇿"
        let hexdump = string.hexDump
        XCTAssertEqual(hexdump, "66 6c 61 67 73 20 1f1e7 1f1f7 1f1f3 1f1ff")
        printClassAndFunc(info: "\(string), \(hexdump)")
        print("---- |\(string)| |\(hexdump)|")

        // flags.count // → 2
        // To inspect the Unicode scalars a string is composed of, use the unicodeScalars view. Here, we format the scalar values as hex numbers in the common format for code points:

        let flagsArr = string.unicodeScalars.map {
            "U+\(String($0.value, radix: 16, uppercase: true))"
        }
        print("--- testHexDump2 flagsArr=", flagsArr)
        // → ["U+1F1E7", "U+1F1F7", "U+1F1F3", "U+1F1FF9"]
        print("--- testHexDump2 hexDump=", string.hexDump)
        // 1f1e7 1f1f7 1f1f3 1f1ff
    }
}

// var hexDump: String {
//    let arr = unicodeScalars.map {
//        String(format: "%02x", $0.value)
//    }
//    return arr.joined(separator: " ")
// }
//
// var dump: String {
//    let arr = unicodeScalars.map {
//        String($0.value, radix: 16, uppercase: true)
//    }
//    return arr.joined(separator: " ")
// }
//
// func hexdump(step: Int = 10) {
//    for i in stride(from: 0, to: count, by: step) {
//        let sub = dropFirst(i).prefix(step) as Substring
//        print(sub)
//    }
// }

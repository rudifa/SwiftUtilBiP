//
//  HexUtilTests.swift v.0.2.0
//  SwiftUtilBiPTests
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

    func test_Data_toString() {
        struct Lang: Codable {
            var name: String
            var version: Double
        }

        let lang = Lang(name: "Swift", version: 5.3)

        let data = try! lang.encode()
        XCTAssertEqual(data.toString!, #"{"name":"Swift","version":5.2999999999999998}"#)
    }
}

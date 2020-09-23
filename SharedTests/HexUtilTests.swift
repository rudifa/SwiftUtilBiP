//
//  HexUtilTests.swift v.0.3.1
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
    }

    func testHexDump_func() {
        do {
            let string = "Hello Swift\t 5.3"
            let hexdump = string.hexDump(lineSize: 8)
            let expected = """
            48 65 6c 6c 6f 20 53 77
            69 66 74 09 20 35 2e 33
            """
            XCTAssertEqual(hexdump, expected)
            printClassAndFunc(info: "string= \(string), hexdump= \(hexdump)")
        }
        do {
            let string = "country flags 🇧🇷🇳🇿"
            let hexdump = string.hexDump(lineSize: 8)
            let expected = """
            63 6f 75 6e 74 72 79 20
            66 6c 61 67 73 20 1f1e7 1f1f7
            1f1f3 1f1ff
            """
            XCTAssertEqual(hexdump, expected)
            printClassAndFunc(info: "string= \(string), hexdump= \(hexdump)")
        }
    }

    func test_DataToString() {
        struct Lang: Codable {
            var name: String
            var version: Double
        }

        let lang = Lang(name: "Swift", version: 5.3)

        let data: Data? = lang.encode()
        XCTAssertEqual(data!.toString!, #"{"name":"Swift","version":5.2999999999999998}"#)
    }
}

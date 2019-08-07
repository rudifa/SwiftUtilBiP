//
//  StringUtilTests.swift v.0.2.1
//  Swift4UtilTests
//
//  Created by Rudolf Farkas on 22.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import XCTest

class StringUtilTests: XCTestCase {
    func test_camelCaseSplit() {
        XCTAssertEqual("HelloThere".camelCaseSplit, "Hello There")
        XCTAssertEqual("".camelCaseSplit, "")
        XCTAssertEqual("A".camelCaseSplit, "A")
        XCTAssertEqual("ABRACADABRA".camelCaseSplit, "A B R A C A D A B R A")
        XCTAssertEqual("IoT".camelCaseSplit, "Io T")
        XCTAssertEqual("camelCaseSplit".camelCaseSplit, "Camel Case Split")

        let string = "camelCaseSplit"
        print("---- |\(string)| |\(string.camelCaseSplit)|")
    }
}

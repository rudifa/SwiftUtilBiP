//
//  DebugUtilTests.swift  v.0.2.1
//  SwiftUtilBiPTests
//
//  Created by Rudolf Farkas on 23.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import XCTest

class DebugUtilTests: XCTestCase {
    func test_printClassAndFunc() {
        printClassAndFunc(info: "more info")
        printClassAndFunc(info: "@ even more info at this time")
        printClassAndFunc(info: "@ even more info a tad later")

        XCTAssertEqual(formatClassAndFunc(info: "more info"),
                       "---- DebugUtilTests.test_printClassAndFunc() more info")

//        XCTAssertTrue(formatClassAndFunc(info: "@ even more info at this time") ~=
//            #"^---- \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{6} DebugUtilTests.test_printClassAndFunc\(\)  even more info at this time$"#)

        xctAssertMatches(formatClassAndFunc(info: "@ even more info at this time"),
                         #"^---- \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{6} DebugUtilTests.test_printClassAndFunc\(\)  even more info at this time$"#)

//        XCTAssertTrue(formatClassAndFunc(info: "@ even more info a tad later") ~=
//            #"^---- \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{6} DebugUtilTests.test_printClassAndFunc\(\)  even more info a tad later$"#)

        xctAssertMatches(formatClassAndFunc(info: "@ even more info a tad later"),
            #"^---- \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{6} DebugUtilTests.test_printClassAndFunc\(\)  even more info a tad later$"#)
    }
}

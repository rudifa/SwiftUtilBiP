//
//  DebugUtilTests.swift  v.0.2.0
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

        printClassAndFunc(info: "\(NSFullUserName())")
    }
}

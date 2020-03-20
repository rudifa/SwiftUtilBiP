//
//  EnumIteratorTests.swift v.0.2.0
//  SwiftUtilBiPIOSTests
//
//  Created by Rudolf Farkas on 18.03.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import XCTest

class EnumIteratorTests: XCTestCase {
    override func setUp() {}

    override func tearDown() {}

    enum Windrose: CaseIterable, Equatable {
        case north, east, south, west
    }

    func test_enum_next() {
        var side = Windrose.north
        XCTAssertEqual(side, .north)
        side = side.next
        XCTAssertEqual(side, .east)
        side = side.next
        XCTAssertEqual(side, .south)
        side = side.next
        XCTAssertEqual(side, .west)
        side = side.next
        XCTAssertEqual(side, .north)
        side = side.next
        XCTAssertEqual(side, .east)
    }

    func test_enum_increment() {
        var side = Windrose.north
        XCTAssertEqual(side, .north)
        side.increment()
        XCTAssertEqual(side, .east)
        side.increment()
        XCTAssertEqual(side, .south)
        side.increment()
        XCTAssertEqual(side, .west)
        side.increment()
        XCTAssertEqual(side, .north)
        side.increment()
        XCTAssertEqual(side, .east)
    }

    func test_enum_incremented() {
        var side = Windrose.north
        XCTAssertEqual(side, .north)

        XCTAssertEqual(side.incremented(), .east)
        XCTAssertEqual(side.incremented(), .south)
        XCTAssertEqual(side.incremented(), .west)
        XCTAssertEqual(side.incremented(), .north)
        XCTAssertEqual(side.incremented(), .east)
    }
}

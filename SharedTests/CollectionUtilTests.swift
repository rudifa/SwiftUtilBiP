//
//  CollectionUtilTests.swift v.0.1.0
//  SwiftUtilBiPIOSTests
//
//  Created by Rudolf Farkas on 24.12.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import XCTest

class CollectionUtilTests: XCTestCase {
    override func setUp() {}

    override func tearDown() {}

    func test_updatePreservingOrder() {
        let aaa = [5, 4, 3, 2, 1]

        XCTAssertEqual(aaa.updatePreservingOrder(from: aaa), [5, 4, 3, 2, 1])
        XCTAssertEqual(aaa.updatePreservingOrder(from: [1, 2, 3, 4, 5]), [5, 4, 3, 2, 1])
        XCTAssertEqual(aaa.updatePreservingOrder(from: [1, 2, 3, 4, 5, 6, 7]), [5, 4, 3, 2, 1, 6, 7])
        XCTAssertEqual(aaa.updatePreservingOrder(from: [3, 4, 5, 6, 7]), [5, 4, 3, 6, 7])
        XCTAssertEqual(aaa.updatePreservingOrder(from: [6, 7]), [6, 7])
    }
}

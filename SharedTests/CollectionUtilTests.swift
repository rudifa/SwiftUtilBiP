//
//  CollectionUtilTests.swift v.0.1.2
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

    func test_closest() {
        func indexPath(row: Int, section: Int = 2) -> IndexPath {
            return IndexPath(row: row, section: section)
        }

        let testPaths0 = [IndexPath]()
        XCTAssertNil(testPaths0.closest(to: indexPath(row: 12)))

        let testPaths1 = [indexPath(row: 5)]
        XCTAssertEqual(testPaths1.closest(to: indexPath(row: 0)), indexPath(row: 5))
        XCTAssertEqual(testPaths1.closest(to: indexPath(row: 4)), indexPath(row: 5))
        XCTAssertEqual(testPaths1.closest(to: indexPath(row: 5)), indexPath(row: 5))
        XCTAssertEqual(testPaths1.closest(to: indexPath(row: 6)), indexPath(row: 5))
        XCTAssertEqual(testPaths1.closest(to: indexPath(row: 9)), indexPath(row: 5))

        let testPaths3 = [indexPath(row: 5), indexPath(row: 10), indexPath(row: 14)]
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 4)), indexPath(row: 5))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 5)), indexPath(row: 5))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 6)), indexPath(row: 5))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 7)), indexPath(row: 5))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 8)), indexPath(row: 10))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 9)), indexPath(row: 10))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 10)), indexPath(row: 10))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 11)), indexPath(row: 10))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 12)), indexPath(row: 10))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 13)), indexPath(row: 14))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 14)), indexPath(row: 14))
        XCTAssertEqual(testPaths3.closest(to: indexPath(row: 15)), indexPath(row: 14))
    }
}

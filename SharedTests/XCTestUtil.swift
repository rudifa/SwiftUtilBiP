//
//  XCTestUtil.swift
//  SwiftUtilBiPIOS
//
//  Created by Rudolf Farkas on 21.03.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import Foundation
import XCTest

func xctAssertMatches(
    _ actual: String,
    _ pattern: String,
    file: StaticString = #file, line: UInt = #line
) {
    if !actual.doesMatch(regex: pattern) {
        XCTFail("match '\(actual)' against pattern '\(pattern)'",
                file: file, line: line)
    }
}

//
//  OptionalUtil.swift
//  Swift4Util
//
//  Created by Rudolf Farkas on 15.10.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Int {
    /// Increment an optional Int
    ///
    /// - Parameter val: to increment by
    public mutating func increment(by val: Int = 1) {
        self = (self ?? 0) + val
    }
}

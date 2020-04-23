//
//  EnumUtil.swift v.0.2.1
//  SwiftUtilBiPIOS
//
//  Created by Rudolf Farkas on 18.03.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import Foundation

// https://stackoverflow.com/questions/51103795/how-to-get-next-case-of-enumi-e-write-a-circulating-method-in-swift-4-2
/// Extension adds a circular iterator to a CaseIterable item, usually an enum
///     enum MyEnum: CaseIterable { case a, b, c }
///     var letter = MyEnum.a
///     letter = letter.next
extension CaseIterable where Self: Equatable {

    /// Returns allCases as Array
    private var all: [Self] {
        return Array(Self.allCases)
    }

    /// Returns the index of self
    private var index: Int {
        return all.firstIndex(of: self)!
    }
    private var count: Int {
        return Self.allCases.count
    }

    /// Returns the next enumerated value (circular)
    var next: Self {
        return all[(index+1) % count]
    }

    /// Returns the previous enumerated value (circular)
    var prev: Self {
        return all[(index+count-1) % count]
    }
//    /// Returns the next enumerated value (circular)
//    var next: Self {
//        let all = Array(Self.allCases)
//        let idx = all.firstIndex(of: self)!
//        let next = all.index(after: idx)
//        return all[next == all.endIndex ? all.startIndex : next]
//    }

    /// circular increment or decrement self and return it
    mutating func increment(next: Bool) {
        let all = Array(Self.allCases)
        let idx = all.firstIndex(of: self)!
        if next {
            let index = all.index(after: idx)
            self = all[index == all.endIndex ? all.startIndex : index]
        } else {
            if idx > all.startIndex {
                self = all[all.index(before: idx)]
            } else {
                self = all[all.index(before: all.endIndex)]
            }
        }
    }

    /// increments (circular) the enum value in-place
    mutating func incremented(next: Bool) -> Self {
        increment(next: next)
        return self
    }
}


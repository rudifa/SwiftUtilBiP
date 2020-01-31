//
//  CollectionUtil.swift v.0.1.1
//  SwiftUtilBiPIOS
//
//  Created by Rudolf Farkas on 24.12.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    /// Return array containing elements of self that are also in other, plus elements from other that are not in self
    /// - Parameter other: the array to update from
    func updatePreservingOrder(from other: Array) -> [Element] {
        var updated: [Element] = filter { other.contains($0) }
        updated += other.filter { !self.contains($0) }
        return updated
    }
}

extension Array where Element == IndexPath {
    /// Return element from self that is closest (in .row value) to the elt
    /// - Parameter elt: element to compare to self elements
    func closest(_ elt: Element) -> Element? {
        guard let first = self.first else { return nil }
        return reduce(first) { abs(elt.row - $1.row) < abs(elt.row - $0.row) ? $1 : $0 }
    }
}


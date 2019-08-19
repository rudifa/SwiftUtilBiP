//
//  DictUtil.swift v.0.1.0
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 30.06.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

/// Packs two hashable items into a hashable struct, so that the struct can be used as a key in a dictionary
struct HashablePair<P1, P2>: Hashable where P1: Hashable, P2: Hashable {
    var p1: P1
    var p2: P2
    init(_ p1: P1, _ p2: P2) {
        self.p1 = p1
        self.p2 = p2
    }
}

//
//  DictUtilTests.swift
//  SwiftUtilBiPTests
//
//  Created by Rudolf Farkas on 30.06.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import XCTest

class DictUtilTests: XCTestCase {
    func testHashablePair() {
        enum State {
            case black, red, green, blue
        }

        enum Event {
            case done, cancel, reset
        }

        // TODO WHY Use of undeclared type 'HashablePair' when compiled in SwiftPackage

        //        typealias State_Event = HashablePair<State, Event> // Use of undeclared type 'HashablePair'

        typealias State_Event = HashablePair<State, Event>

        let dictionary: Dictionary<State_Event, State> = [
            State_Event(.black, .cancel): .red,
            State_Event(.black, .done): .black,
            State_Event(.red, .cancel): .black,
            State_Event(.red, .done): .green,
            State_Event(.green, .cancel): .black,
            State_Event(.green, .done): .blue,
            State_Event(.blue, .cancel): .black,
            State_Event(.blue, .done): .red,
        ]

        XCTAssertEqual(dictionary[State_Event(.black, .cancel)], .red)
        XCTAssertEqual(dictionary[State_Event(.blue, .cancel)], .black)
        XCTAssertNil(dictionary[State_Event(.blue, .reset)])

        for (key, _) in dictionary {
            print("hash of key=", key.hashValue)
        }
    }
}

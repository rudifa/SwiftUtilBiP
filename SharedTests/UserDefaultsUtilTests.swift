//
//  UserSettingsUtilTests.swift v.0.1.0
//  SwiftUtilBiPTests
//
//  Created by Rudolf Farkas on 22.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import XCTest

class UserSettingsUtilTests: XCTestCase {
    struct Language: Codable, Equatable {
        var name: String
        var version: String
    }

    override func setUp() {}
    override func tearDown() {}

    func test_extensionUserDefaults() {
        let defaults = UserDefaults.standard
        let languageKey = "defaultLanguage"

        // create an instance
        let testLanguage = Language(name: "Swift", version: "4")

        // save in defaults
        defaults.set(value: testLanguage, forKey: languageKey)

        // restore from defaults should succeed
        if let language: Language = defaults.get(forKey: languageKey) {
            XCTAssertEqual(language, testLanguage)
        } else {
            XCTAssert(false)
        }

        // remove from defaults
        defaults.remove(forKey: languageKey)

        // restore from defaults should fail
        if let _: Language = defaults.get(forKey: languageKey) {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
}

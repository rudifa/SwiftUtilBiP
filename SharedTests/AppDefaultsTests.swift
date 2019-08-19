//
//  AppDefaultsTests.swift v.0.2.0
//  SwiftUtilBiPTests
//
//  Created by Rudolf Farkas on 08.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import XCTest

class AppDefaultsTests: XCTestCase {
    let prefLangKey = "preferredLanguage"

    struct ProgLang: Codable, Equatable {
        var name: String
        var version: String
    }

    override func setUp() {}
    override func tearDown() {}

    func test_AppDefaults() {
        // try to get from AppDefaults
        do {
            let val = AppDefaults<ProgLang>.setting(for: prefLangKey)
            XCTAssertNil(val)
        }

        let prefLang = ProgLang(name: "Swift", version: "5.0")

        // save to AppDefaults
        do {
            let saved = AppDefaults.set(prefLang, forKey: prefLangKey)
            XCTAssertTrue(saved)
        }

        // try again to get from UserDefaults
        do {
            let val = AppDefaults<ProgLang>.setting(for: prefLangKey)
            XCTAssertEqual(val, prefLang)
        }

        // remove from AppDefaults
        AppDefaults<ProgLang>.remove(forKey: prefLangKey)

        // verify that the setting is gone
        do {
            let val = AppDefaults<ProgLang>.setting(for: prefLangKey)
            XCTAssertNil(val)
        }

        // verify that the setting is gone, another way
        do {
            let val: ProgLang? = AppDefaults.setting(for: prefLangKey)
            XCTAssertNil(val)
        }
    }
}

//
//  CodableUtilTests.swift v.0.1.2
//  Swift4UtilTests
//
//  Created by Rudolf Farkas on 23.06.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import XCTest

struct Language: Codable, Equatable {
    var name: String
    var version: String
}

class CodableUtilTests: XCTestCase {
    override func setUp() {}

    override func tearDown() {}

    func testEncodableDecodable() {
        let language = Language(name: "Swift", version: "5")

        // encode with one line of code
        let data = try? language.encode()

        let language2 = try? Language.decode(from: data!)
        XCTAssertEqual(language, language2)

        let language3 = try? Language.decode(from: Data())
        XCTAssertNil(language3)
    }
}

//    https://gist.github.com/eMdOS/88a465e8898a0600d0a343e14
//
//    extension Encodable {
//        func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
//            return try encoder.encode(self)
//        }
//    }
//
//    extension Decodable {
//        static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
//            return try decoder.decode(Self.self, from: data)
//        }
//    }
//
//    sample code:
//
//    struct Language: Codable {
//        var name: String
//        var version: String
//    }
//
//    // create a new language
//    let language = Language(name: "Swift", version: "4")
//
//    // encode with one line of code
//    let data = try? language.encode()
//
//    let lang: Language? = try? Language.decode(from: data!)

//
//  CodableUtilTests.swift v.0.2.0
//  SwiftUtilBiPTests
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

    func test_EncodableDecodable_Data() {
        let language = Language(name: "Swift", version: "5")

        // encode to Data?
        let data: Data? = language.encode()

        // decode to Self?
        let language2 = Language.decode(from: data!)

        // compare
        XCTAssertEqual(language, language2)

        // test with empty Data
        let language3 = Language.decode(from: Data())
        XCTAssertNil(language3)
    }


    func test_EncodableDecodable_String() {
        let language = Language(name: "Swift", version: "5")

        // encode to String?
        let string: String? = language.encode()

        // decode to Self?
        let language2 = Language.decode(from: string!)

        // compare
        XCTAssertEqual(language, language2)

        // test with empty String
        let language3 = Language.decode(from: String())
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

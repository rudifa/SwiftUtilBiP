//
//  SharedDefaultsTests.swift v.0.2.0
//  SwiftRfUtil
//
//  Created by Rudolf Farkas on 13.03.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

// @testable import SwiftRfUtil
import XCTest

final class SharedDefaultsTests: XCTestCase {
    func test_LocalAndSharedCodableDefaults() {
        /// Return the approximate number of seconds in a year
        var year: TimeInterval { return TimeInterval(365 * 24 * 60 * 60) }

        // A struct that an app wants to save in UserDefaults
        struct SubscriptionInfo: Codable, Equatable {
            let productId: String
            let purchaseDate: Date?
        }

        // define several defaults, like an app would do,
        // for storage in UserDefaults.standard (local to the app)
        enum LocalCodableDefaults {
            // define keys to defaults
            enum Key: String {
                case userId
                case subscriptionInfo
            }

            @CodableUserDefault(key: Key.userId,
                                defaultValue: "UNKNOWN")
            static var userId: String

            @CodableUserDefault(key: Key.subscriptionInfo,
                                defaultValue: SubscriptionInfo(productId: "ABBA", purchaseDate: Date(timeIntervalSince1970: 2 * year)))
            static var subscriptionInfo: SubscriptionInfo
        }

        // define several defaults, like an app would do,
        // for storage in sharedDefaults (shared among several apps)
        enum SharedCodableDefaults {
            // store shared among several apps
            static let sharedDefaults = UserDefaults(suiteName: "group.com.share-telematics.calshare")!

            // keys to defaults
            enum Key: String {
                case selectedCalendarTitle
                case calendarTitles
            }

            @CodableUserDefault(key: Key.calendarTitles,
                                defaultValue: [],
                                userDefaults: sharedDefaults)
            static var calendarTitles: [String]

            @CodableUserDefault(key: Key.selectedCalendarTitle,
                                defaultValue: "Select a calendar...",
                                userDefaults: sharedDefaults)
            static var selectedCalendarTitle: String
        }

        // restore to default values
        LocalCodableDefaults.userId = "UNKNOWN"
        LocalCodableDefaults.subscriptionInfo = SubscriptionInfo(productId: "ABBA", purchaseDate: Date(timeIntervalSince1970: 2 * year))
        SharedCodableDefaults.calendarTitles = []
        SharedCodableDefaults.selectedCalendarTitle = "Select a calendar..."

        XCTAssertEqual(LocalCodableDefaults.userId, "UNKNOWN")
        XCTAssertEqual(LocalCodableDefaults.subscriptionInfo, SubscriptionInfo(productId: "ABBA", purchaseDate: Date(timeIntervalSince1970: 2 * year)))
        XCTAssertEqual(SharedCodableDefaults.calendarTitles, [])
        XCTAssertEqual(SharedCodableDefaults.selectedCalendarTitle, "Select a calendar...")

        // modify default values
        LocalCodableDefaults.userId = "Wendy"
        LocalCodableDefaults.subscriptionInfo = SubscriptionInfo(productId: "DADA", purchaseDate: Date(timeIntervalSince1970: -55 * year))
        SharedCodableDefaults.calendarTitles = ["Code_Cal", "Home", "Work"]
        SharedCodableDefaults.selectedCalendarTitle = "Code_Cal"

        XCTAssertEqual(LocalCodableDefaults.userId, "Wendy")
        XCTAssertEqual(LocalCodableDefaults.subscriptionInfo, SubscriptionInfo(productId: "DADA", purchaseDate: Date(timeIntervalSince1970: -55 * year)))
        XCTAssertEqual(SharedCodableDefaults.calendarTitles, ["Code_Cal", "Home", "Work"])
        XCTAssertEqual(SharedCodableDefaults.selectedCalendarTitle, "Code_Cal")
    }
}

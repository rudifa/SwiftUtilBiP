//
//  DateIntervalTests.swift v.0.3.0
//  EP_CalendarTests
//
//  Created by Rudolf Farkas on 13.09.19.
//  Copyright © 2019 Eric PAJOT. All rights reserved.
//

import XCTest
class DateIntervalTests: XCTestCase {
    func testOperations() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_CH")

        let dateIntervalFormatter = DateIntervalFormatter()
        dateIntervalFormatter.locale = Locale(identifier: "fr_CH")

        func format(interval: DateInterval) -> String {
            return "\(dateIntervalFormatter.string(from: interval)!) [\(interval.duration)]"
        }

        let now = Date()

        let today = Calendar.current.dateInterval(of: .day, for: now)!
        let oneDay = today.duration
        let thisHour = Calendar.current.dateInterval(of: .hour, for: now)!
        let oneHour = thisHour.duration
        let theseThreeHours = DateInterval(start: now.wholeHour!, duration: 3.0 * oneHour)
        let nextHour = DateInterval(start: thisHour.end, duration: oneHour)
        let tomorrow = DateInterval(start: today.end, duration: oneDay)

        let startInThreeQuartersOfHour = DateInterval(start: thisHour.start + oneHour * 0.75, duration: oneHour / 2)

        printClassAndFunc(info: "today \(format(interval: today))")
        printClassAndFunc(info: "thisHour \(format(interval: thisHour))")
        printClassAndFunc(info: "theseThreeHours \(format(interval: theseThreeHours))")
        printClassAndFunc(info: "nextHour \(format(interval: nextHour))")
        printClassAndFunc(info: "tomorrow \(format(interval: tomorrow))")
        printClassAndFunc(info: "startInThreeQuartersOfHour \(format(interval: startInThreeQuartersOfHour))")

        let intersection1 = thisHour.intersection(with: thisHour)!
        dateIntervalFormatter.string(from: intersection1)
        printClassAndFunc(info: "thisHour.intersection(with: thisHour) \(format(interval: intersection1))]")
        printClassAndFunc(info: "thisHour.intersects(thisHour) \(thisHour.intersects(thisHour))")

        let intersection2 = thisHour.intersection(with: nextHour)!
        dateIntervalFormatter.string(from: intersection2)
        printClassAndFunc(info: "thisHour.intersection(nextHour) \(dateIntervalFormatter.string(from: intersection2)!) [\(intersection2.duration)]")
        printClassAndFunc(info: "thisHour.intersects(nextHour) \(thisHour.intersects(nextHour))")

        let intersection3 = thisHour.intersection(with: startInThreeQuartersOfHour)!
        dateIntervalFormatter.string(from: intersection3)
        printClassAndFunc(info: "thisHour.intersection(with: startInThreeQuartersOfHour) \(format(interval: intersection3))]")
        printClassAndFunc(info: "thisHour.intersects(startInThreeQuartersOfHour) \(thisHour.intersects(startInThreeQuartersOfHour))")

        let intersection4 = thisHour.intersection(with: today)!
        dateIntervalFormatter.string(from: intersection4)
        printClassAndFunc(info: "thisHour.intersection(with: today) \(format(interval: intersection4))]")
        printClassAndFunc(info: "thisHour.intersects(today) \(thisHour.intersects(today))")

        if let intersection5 = thisHour.intersection(with: tomorrow) {
            printClassAndFunc(info: "thisHour.intersection(with: tomorrow) \(format(interval: intersection5))]")
        } else {
            printClassAndFunc(info: "thisHour.intersection(tomorrow) == nil")
        }
        printClassAndFunc(info: "thisHour.intersects(tomorrow) \(thisHour.intersects(tomorrow))")

        let intersection6 = thisHour.intersection(with: theseThreeHours)!
        printClassAndFunc(info: "thisHour.intersection(with: theseThreeHours) \(format(interval: intersection6))]")
    }
}

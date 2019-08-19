//
//  DateUtilTests.swift v.0.1.6
//  SwiftUtilBiPTests
//
//  Created by Rudolf Farkas on 18.06.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import XCTest

class DateUtilTests: XCTestCase {
    func test_TimeZone() {
        let tzCurrent = TimeZone.current
        print("--- tzCurrent=\(tzCurrent)") // --- tzCurrent=Europe/Zurich (current)
        print("--- timeZoneDataVersion=\(TimeZone.timeZoneDataVersion)") // 2019b
        let tzUTC = TimeZone(identifier: "UTC")
        print("--- tzUTC=\(String(describing: tzUTC))") // --- tzUTC=Optional(GMT (fixed))

        let date = Date()
        let tzCurrentDiffSeconds = tzCurrent.secondsFromGMT(for: date)
        print("--- tzCurrentDiffSeconds=\(tzCurrentDiffSeconds)") // --- tzCurrentDiffSeconds=7200 as of 18 Aug 2019
        let tzUTCDiffSeconds = tzUTC!.secondsFromGMT(for: date)
        print("--- tzUTCDiffSeconds=\(tzUTCDiffSeconds)") // --- tzUTCDiffSeconds=0 // always
        XCTAssertEqual(tzUTCDiffSeconds, 0)
    }

    func test_DateExtFormats() {
        let date = Date()
        print("--- date=", date, "ddMMyyy=", date.ddMMyyyy)
        print("--- time=", date, "HHmmss=", date.HHmmss)
        print("--- Today \(date.EEEEddMMyyyy) at \(date.HHmmss) tag= \(date.timeTag)")

        // set an arbitrary date
        let date0 = Date(timeIntervalSince1970: -1_006_344_000)
        let secondsFromUTC = TimeZone.current.secondsFromGMT(for: date0)
        // get the corresponding date-time in UTC
        // so that the following tests become independent of the current time zone where tests are executed
        let date0UTC = date0.addingTimeInterval(-TimeInterval(secondsFromUTC))
        XCTAssertEqual("10.02.1938", date0UTC.ddMMyyyy)
        XCTAssertEqual("12:00:00", date0UTC.HHmmss)
        XCTAssertEqual("12:00:00.000", date0UTC.HHmmssSSS)
        XCTAssertEqual("February 1938", date0UTC.MMMM_yyyy)
        print("--- Once upon a time", date0UTC.ddMMyyyy, "at", date0.HHmmss, "...")
    }

    func testInit() {
        let date = Date(seconds: 0)
        XCTAssertEqual(date, Date(timeIntervalSinceReferenceDate: 0))
        XCTAssertEqual(date.ddMMyyyy, "01.01.2001")
    }

    func testTimeStampAndTag() {
        let date = Date(seconds: 0)
        XCTAssertEqual(date.timeStamp, 978_307_200.0)
        XCTAssertEqual(date.timeTag, "978307200_00000")
    }

    func test_CalendarFeatures() {
        // see https://nshipster.com/datecomponents/
        // DateComponents is a useful, but ambiguous type.
        // Taken in one context, date components can be used to represent a specific calendar date. But in another context, the same object might instead be used as a duration of time. For example, a date components object with year set to 2018, month set to 10, and day set to 10 could represent a period of 2018 years, 10 months, and 10 days or the tenth day of the tenth month in the year 2018.

        let calendar = Calendar.current
        // Date from DateComponents
        let dateComponents = DateComponents(timeZone: TimeZone.current, year: 2018, month: 6, day: 15, hour: 10)
        let date1 = Calendar.current.date(from: dateComponents)!
        XCTAssertEqual([date1.EEEEddMMyyyy, date1.HHmmss], ["Friday 15.06.2018", "10:00:00"])

        // Date interval - start and end of month for date1
        let dateIntervalOfMonth = calendar.dateInterval(of: .month, for: date1)
        let startOfMonth = dateIntervalOfMonth!.start
        let endOfMonth = dateIntervalOfMonth!.end
        XCTAssertEqual([startOfMonth.EEEEddMMyyyy, startOfMonth.HHmmss], ["Friday 01.06.2018", "00:00:00"])
        XCTAssertEqual([endOfMonth.EEEEddMMyyyy, endOfMonth.HHmmss], ["Sunday 01.07.2018", "00:00:00"])

        // DateComponents as a duration of time
        let date2 = Calendar.current.date(byAdding: DateComponents(year: 1), to: date1)!
        XCTAssertEqual([date2.EEEEddMMyyyy, date2.HHmmss], ["Saturday 15.06.2019", "10:00:00"])

        // Symbols
        let monthSymbols = Calendar.current.monthSymbols
        XCTAssertEqual(monthSymbols, ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"])
        let weekdaySymbols = Calendar.current.weekdaySymbols
        XCTAssertEqual(weekdaySymbols, ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
        let weekdaySymbols_M0 = Calendar.current.weekdaySymbols_M0
        XCTAssertEqual(weekdaySymbols_M0, ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"])
    }

    func test_DateExtCalComp() {
        // create date1 from components, decompose and compare
        let d1Comp = DateComponents(timeZone: TimeZone.current, year: 2019, month: 7, day: 26, hour: 10)
        var d1 = Calendar.current.date(from: d1Comp)!

        // test properties of date d1
        XCTAssertEqual([d1.year, d1.month, d1.month_0, d1.day, d1.day_0, d1.weekday, d1.weekday_0M, d1.daysInMonth.count],
                       [2019, 7, 6, 26, 25, 6, 4, 31])

        XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.day), String(d1.day_0)], ["Friday 26.07.2019", "26", "25"])

        // test first of the month for date d1
        XCTAssertEqual([d1.month1st.EEEEddMMyyyy, String(d1.month1stWeekday), String(d1.month1stWeekday_0M)], ["Monday 01.07.2019", "2", "0"])
        XCTAssertEqual([d1.month1st.EEEEddMMyyyy, String(d1.month1st.weekday), String(d1.month1st.weekday_0M)], ["Monday 01.07.2019", "2", "0"])

        // decrement d1 by 1 day and test properties
        d1.incrementBy(component: .day, value: -1)
        XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.month1stWeekday), String(d1.month1stWeekday_0M)], ["Thursday 25.07.2019", "2", "0"])
        XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.day), String(d1.day_0)], ["Thursday 25.07.2019", "25", "24"])

        // decrement d1 by 22 days and test properties
        d1.incrementBy(component: .day, value: -22)
        XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.day), String(d1.day_0)], ["Wednesday 03.07.2019", "3", "2"])

        // d1 fast forward to March 2020
        for _ in 1 ... 8 { d1.nextMonth() }
        XCTAssertEqual(d1.year, 2020); XCTAssertEqual(d1.month, 3); XCTAssertEqual(d1.daysInMonth.count, 31)
        XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.day), String(d1.day_0)], ["Tuesday 03.03.2020", "3", "2"])

        // d1 back to February 2020
        d1.prevMonth()
        XCTAssertEqual(d1.year, 2020); XCTAssertEqual(d1.month, 2); XCTAssertEqual(d1.daysInMonth.count, 29)
        XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.day), String(d1.day_0)], ["Monday 03.02.2020", "3", "2"])

        // d1 faster back to February 2019
        d1.incrementBy(component: .year, value: -1)
        XCTAssertEqual(d1.year, 2019); XCTAssertEqual(d1.month, 2); XCTAssertEqual(d1.daysInMonth.count, 28)
        XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.day), String(d1.day_0)], ["Sunday 03.02.2019", "3", "2"])

        // isToday?
        var dd = Date()
        XCTAssertTrue(dd.isToday)
        print("--- \(dd.ddMMyyyy) is " + (dd.isToday ? "" : "not") + "today")
        dd.incrementBy(component: .day, value: 1)
        XCTAssertFalse(dd.isToday)
        dd.incrementBy(component: .day, value: -1)
        XCTAssertTrue(dd.isToday)
        dd.nextMonth()
        print("--- \(dd.ddMMyyyy) is " + (dd.isToday ? "" : "not ") + "today")
    }
}

//
//  DateUtilTests.swift v.0.2.0
//  SwiftUtilBiPTests
//
//  Created by Rudolf Farkas on 18.06.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import XCTest
class DateUtilTests: XCTestCase {
    func test_TimeZoneFeatures() {
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

    func test_ExtendedDateFormats() {
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

    func test_ExtendedDateModsAndProps() {
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

        // test last of the month for date d1
        XCTAssertEqual([d1.monthLast.EEEEddMMyyyy, d1.monthLast.HHmmssSSS, String(d1.month1stWeekday), String(d1.month1stWeekday_0M)], ["Wednesday 31.07.2019", "00:00:00.000", "2", "0"])
        XCTAssertEqual([d1.monthLast.EEEEddMMyyyy, d1.monthLast.HHmmssSSS, String(d1.month1st.weekday), String(d1.month1st.weekday_0M)], ["Wednesday 31.07.2019", "00:00:00.000", "2", "0"])

        // test first of the next month for date d1
        var d1_month1st = d1.month1st
        d1_month1st.nextMonth()
        XCTAssertEqual([d1_month1st.month1st.EEEEddMMyyyy, d1.monthLast.HHmmssSSS, String(d1_month1st.month1stWeekday), String(d1_month1st.month1stWeekday_0M)], ["Thursday 01.08.2019", "00:00:00.000", "5", "3"])

        do {
            // decrement d1 by 1 day and test properties
            let d2 = d1.incremented(by: .day, times: -1)
            XCTAssertEqual([d2.EEEEddMMyyyy, String(d2.month1stWeekday), String(d2.month1stWeekday_0M)], ["Thursday 25.07.2019", "2", "0"])
            d1.increment(by: .day, times: -1)
            XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.month1stWeekday), String(d1.month1stWeekday_0M)], ["Thursday 25.07.2019", "2", "0"])
            XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.day), String(d1.day_0)], ["Thursday 25.07.2019", "25", "24"])
        }
        do {
            // decrement d1 by 1 day and test properties
            let d2 = d1.incremented(by: .day, times: -1)
            XCTAssertEqual(d2.EEEE_ddMMyyyy_HHmmss_ZZZZZ, "Wednesday 24.07.2019 10:00:00 +02:00")
            d1.increment(by: .day, times: -1)
            XCTAssertEqual(d2.EEEE_ddMMyyyy_HHmmss_ZZZZZ, "Wednesday 24.07.2019 10:00:00 +02:00")
            d1.increment(by: .day, times: +1)
            XCTAssertEqual(d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, "Thursday 25.07.2019 10:00:00 +02:00")
        }

        // decrement d1 by 22 days and test properties
        d1.increment(by: .day, times: -22)
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
        d1.increment(by: .year, times: -1)
        XCTAssertEqual(d1.year, 2019); XCTAssertEqual(d1.month, 2); XCTAssertEqual(d1.daysInMonth.count, 28)
        XCTAssertEqual([d1.EEEEddMMyyyy, String(d1.day), String(d1.day_0)], ["Sunday 03.02.2019", "3", "2"])

        // isToday?
        var dd = Date()
        XCTAssertTrue(dd.isToday)
        print("--- \(dd.ddMMyyyy) is " + (dd.isToday ? "" : "not") + "today")
        dd.increment(by: .day, times: 1)
        XCTAssertFalse(dd.isToday)
        dd.increment(by: .day, times: -1)
        XCTAssertTrue(dd.isToday)
        dd.nextMonth()
        print("--- \(dd.ddMMyyyy) is " + (dd.isToday ? "" : "not ") + "today")

        print("--- date: \(dd.ddMMyyyy)  \(dd.HHmmss) ")
        print("--- date.wholeHour: \(dd.wholeHour!.ddMMyyyy)  \(dd.wholeHour!.HHmmss) ")
    }

    func test_MoreExtendedDateModsAndProps() {
        let timezone = TimeZone(identifier: "Europe/Zurich")!

//        Getting Time Zone Information
//        var identifier: String
//        The geopolitical region identifier that identifies the time zone.
//        func abbreviation(for: Date) -> String?
//        Returns the abbreviation for the time zone at a given date.
//        func secondsFromGMT(for: Date) -> Int
//        The current difference in seconds between the time zone and Greenwich Mean Time.

        XCTAssertEqual(timezone, TimeZone.current)
        XCTAssertEqual(timezone.identifier, TimeZone.current.identifier)
        XCTAssertEqual(timezone.abbreviation(), TimeZone.current.abbreviation())
        XCTAssertEqual(timezone.secondsFromGMT(), TimeZone.current.secondsFromGMT())

       // create date1 from components, decompose and compare
        let d1Comp = DateComponents(timeZone: timezone, year: 2019, month: 7, day: 26, hour: 10)
        var d1 = Calendar.current.date(from: d1Comp)!
        XCTAssertEqual([d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, String(d1.day), String(d1.day_0)], ["Friday 26.07.2019 10:00:00 +02:00", "26", "25"])

        d1.set(day: 26)
        XCTAssertEqual([d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, String(d1.day), String(d1.day_0)], ["Friday 26.07.2019 10:00:00 +02:00", "26", "25"])

        d1.set(day: 25)
        XCTAssertEqual([d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, String(d1.day), String(d1.day_0)], ["Thursday 25.07.2019 10:00:00 +02:00", "25", "24"])

        d1.set(day: 18)
        XCTAssertEqual([d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, String(d1.day), String(d1.day_0)], ["Thursday 18.07.2019 10:00:00 +02:00", "18", "17"])

        d1.set(day: 1)
        XCTAssertEqual([d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, String(d1.day), String(d1.day_0)], ["Monday 01.07.2019 10:00:00 +02:00", "1", "0"])

        d1.set(hour: 2)
        XCTAssertEqual([d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, String(d1.day), String(d1.day_0)], ["Monday 01.07.2019 02:00:00 +02:00", "1", "0"])

        d1.set(hour: 8)
        XCTAssertEqual([d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, String(d1.day), String(d1.day_0)], ["Monday 01.07.2019 08:00:00 +02:00", "1", "0"])

        d1.set(hour: 16)
        XCTAssertEqual([d1.EEEE_ddMMyyyy_HHmmss_ZZZZZ, String(d1.day), String(d1.day_0)], ["Monday 01.07.2019 16:00:00 +02:00", "1", "0"])

        let d2Comp = DateComponents(timeZone: timezone, year: 2019, month: 9, day: 14, hour: 16, minute: 49, second: 31)
        var d2 = Calendar.current.date(from: d2Comp)!
        XCTAssertEqual(d2.EEEE_ddMMyyyy_HHmmss_ZZZZZ, "Saturday 14.09.2019 16:49:31 +02:00")

        let d3 = d2.setting(hour: 9)
        XCTAssertEqual(d3!.EEEE_ddMMyyyy_HHmmss_ZZZZZ, "Saturday 14.09.2019 09:00:00 +02:00")

        var d4 = d2
        d4.set(hour: 13) // sets .minute and .second to 0
        XCTAssertEqual(d4.EEEE_ddMMyyyy_HHmmss_ZZZZZ, "Saturday 14.09.2019 13:00:00 +02:00")

        d4.set(day: 15) // preserves the hour
        XCTAssertEqual(d4.EEEE_ddMMyyyy_HHmmss_ZZZZZ, "Sunday 15.09.2019 13:00:00 +02:00")

        d2.set(day: 22) // preserves the hour, but sets .minute and .second to 0
        XCTAssertEqual(d2.EEEE_ddMMyyyy_HHmmss_ZZZZZ, "Sunday 22.09.2019 16:00:00 +02:00") }
}

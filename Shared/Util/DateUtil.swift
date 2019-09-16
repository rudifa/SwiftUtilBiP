//
//  DateUtil.swift v.0.2.2
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 18.06.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

// MARK: - Extended Date Formats

extension Date {
    /// Formats the self per format string, using TimeZone.current
    ///
    /// - Parameter fmt: a valid DateFormatter format string
    /// - Returns: date+time string
    private func formatted(fmt: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current // the default is UTC
        formatter.dateFormat = fmt
        return formatter.string(from: self)
    }

    // computed property returns local date string

    /// Returns the local date string like "May 2019"
    var MMMM_yyyy: String {
        return formatted(fmt: "MMMM yyyy")
    }

    /// Returns the local date string like "18.08.2019"
    var ddMMyyyy: String {
        return formatted(fmt: "dd.MM.yyyy")
    }

    /// Returns the local date string including day, like "Sunday 18.08.2019"
    var EEEEddMMyyyy: String {
        return formatted(fmt: "EEEE dd.MM.yyyy")
    }

    /// Returns the local time string like "20:44:23"
    var HHmmss: String {
        return formatted(fmt: "HH:mm:ss")
    }

    /// Returns the local time string with milliseconds, like "12:00:00.000"
    var HHmmssSSS: String {
        return formatted(fmt: "HH:mm:ss.SSS")
    }

    /// Initializes self to the date at the specified secondsInto21stCentury
    ///
    /// - Parameter secondsInto21stCentury: seconds since 00:00:00 UTC on 1 January 2001
    init(seconds secondsInto21stCentury: TimeInterval) {
        self.init(timeIntervalSinceReferenceDate: secondsInto21stCentury)
    }

    /// Returns the detailed local date-time string, like "24.07.2019 10:00:00"
    var ddMMyyyy_HHmmss: String {
        return formatted(fmt: "dd.MM.yyyy HH:mm:ss")
    }

    /// Returns the detailed local date-time string, like "Wednesday 24.07.2019 10:00:00"
    var EEEE_ddMMyyyy_HHmmss: String {
        return formatted(fmt: "EEEE dd.MM.yyyy HH:mm:ss")
    }

    /// Returns the detailed local date-time string, like "Wednesday 24.07.2019 10:00:00 +02:00"
    var EEEE_ddMMyyyy_HHmmss_ZZZZZ: String {
        return formatted(fmt: "EEEE dd.MM.yyyy HH:mm:ss ZZZZZ")
    }

    /// Returns a timestamp (timeIntervalSince1970)
    var timeStamp: TimeInterval { return timeIntervalSince1970 }

    /// Returns a timestamp string (timeIntervalSince1970), like "1566153863_69661"
    var timeTag: String {
        return String(format: "%10.5f", timeStamp).replacingOccurrences(of: ".", with: "_")
    }
}

// MARK: - Extended Date Modifiers and Properties using Calendar and DateComponents

extension Date {
    // MARK: - modifiers

    /// Increments self by component and value
    ///
    /// - Parameters:
    ///   - component: a Calendar.Component like .hour, .day, .month, ...
    ///   - value: number of compoents (hous, days, months, ...)
    mutating func increment(by component: Calendar.Component, times value: Int) {
        self = Calendar.current.date(byAdding: component, value: value, to: self)!
    }

    /// Date incremented by component and value
    func incremented(by component: Calendar.Component, times value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }

    /// Increments self by 1 month
    mutating func nextMonth() {
        increment(by: .month, times: 1)
    }

    /// Decrements self by 1 month
    mutating func prevMonth() {
        increment(by: .month, times: -1)
    }

    /// Returns a date with the day of month modified
    ///
    /// Preserves the .hour, sets .minute and smaller components to 0
    ///
    /// - Parameter day: day of month (1...) to set to
    /// - Returns: modified copy of self or nil if invalid date would be generated
    func setting(day: Int) -> Date? {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
        dateComponents.day = day
        return Calendar.current.date(from: dateComponents)
    }

    /// Modifies self, setting the day of month
    ///
    /// Preserves the .hour, sets .minute and smaller components to 0
    ///
    /// - Parameter day: day of month (1...) to set to
    mutating func set(day: Int) {
        if let date = self.setting(day: day) { self = date }
        else { print("*** set day failed") }
    }

    /// Returns a date with the hour modified
    ///
    /// Sets .minute and smaller components to 0
    ///
    /// - Parameter hour: hour to set to (0...23)
    /// - Returns: modified copy of self or nil if invalid date would be generated
    func setting(hour: Int) -> Date? {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
        dateComponents.hour = hour
        return Calendar.current.date(from: dateComponents)
    }

    /// Modifies self, setting the hour
    ///
    /// Sets .minute and smaller components to 0
    ///
    /// - Parameter hour: hour to set to (0...23)
    mutating func set(hour: Int) {
        if let date = self.setting(hour: hour) { self = date }
        else { print("*** set hour failed") }
    }

    var wholeHour: Date? {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
        return Calendar.current.date(from: dateComponents)
    }

    // MARK: - properties

    /// Returns month (1..12)
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    /// Returns month (0..11)
    var month_0: Int {
        return month - 1
    }

    /// Returns the start date of the month
    var month1st: Date {
        return Calendar.current.dateInterval(of: .month, for: self)!.start
    }

    /// Returns the last date of the month
    var monthLast: Date {
        let then = Calendar.current.dateInterval(of: .month, for: self)!.end // in fact, start of next month
        return then.incremented(by: .day, times: -1)
    }

    /// Returns an array of days. ex. [1, 2, ..., 31]
    var daysInMonth: [Int] {
        return (Calendar.current.range(of: .day, in: .month, for: self)!).map({ $0 })
    }

    /// Returns year
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    /// Returns day in month (1...)
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    /// Returns day in month (0...)
    var day_0: Int {
        return day - 1
    }

    /// Returns weekdayOrdinal (range 1...5, 1 for 1st 7 days of the month, 2 for next 7 days, etc)
    var weekdayOrdinal: Int {
        return Calendar.current.component(.weekdayOrdinal, from: self)
    }

    /// Returns weekday (1...7, 1 is Sunday)
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }

    /// Returns weekday (0...6, 0 is Monday)
    var weekday_0M: Int {
        return (weekday - 2 + 7) % 7
    }

    /// Returns weekday (1...7, 1 is Sunday) of the first day of the month
    var month1stWeekday: Int {
        return month1st.weekday
    }

    /// Returns weekday (0...6, 0 is Monday) of the first day of the month
    var month1stWeekday_0M: Int {
        return month1st.weekday_0M
    }

    /// Returns true if self is today (any hour)
    var isToday: Bool {
        let dateNow = Date()
        return day == dateNow.day && month == dateNow.month && year == dateNow.year
    }
}

// MARK: - Extended Calendar properties

extension Calendar {
    /// Returns array of weekday names, starting with Monday
    var weekdaySymbols_M0: [String] {
        var wkds = weekdaySymbols
        wkds.append(wkds.first!)
        return Array(wkds.dropFirst())
    }
}


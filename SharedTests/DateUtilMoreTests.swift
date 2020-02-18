//
//  DateUtilMoreTests.swift
//  SwiftUtilBiPIOSTests
//
//  Created by Rudolf Farkas on 18.02.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import XCTest

class DateUtilMoreTests: XCTestCase {
    override func setUp() {}

    override func tearDown() {}

    func test_UsingPrivateStorage() {
        // create date1 from components, decompose and compare
        let date1Comp = DateComponents(timeZone: TimeZone.current, year: 2019, month: 7, day: 26, hour: 10, minute: 15, second: 20)
        let date1 = Calendar.current.date(from: date1Comp)!

        let sut = UsingPrivateStorage(date: date1)

        XCTAssertEqual(sut.ymDay.ddMMyyyy_HHmmss, "26.07.2019 00:00:00")
        XCTAssertEqual(sut.yMonth.ddMMyyyy_HHmmss, "01.07.2019 00:00:00")
    }

    func test_UsingPropertyWrappers() {
        // create date1 from components, decompose and compare
        let date1Comp = DateComponents(timeZone: TimeZone.current, year: 2019, month: 7, day: 26, hour: 10, minute: 15, second: 20)
        let date1 = Calendar.current.date(from: date1Comp)!

        var sut = UsingPropertyWrappers(date: date1)

        XCTAssertEqual(sut.yMonth.ddMMyyyy_HHmmss, "01.07.2019 00:00:00")
        XCTAssertEqual(sut.ymDay.ddMMyyyy_HHmmss, "26.07.2019 00:00:00")
        XCTAssertEqual(sut.ymdHours.map({ $0.ddMMyyyy_HHmmss }).joined(separator: " "), "")

        sut.yMonth.increment(by: .month, times: 3)
        sut.ymDay.increment(by: .month, times: 3)

        sut.ymdHours.append(date1)
        XCTAssertEqual(sut.ymdHours, [date1.wholeHour])
        XCTAssertEqual(sut.ymdHours.map({ $0.ddMMyyyy_HHmmss }).joined(separator: " "), "26.07.2019 10:00:00")

        XCTAssertEqual(sut.yMonth.ddMMyyyy_HHmmss, "01.10.2019 00:00:00")
        XCTAssertEqual(sut.ymDay.ddMMyyyy_HHmmss, "26.10.2019 00:00:00")

        sut.ymdHours.removeAll()
        XCTAssertEqual(sut.ymdHours, [])
    }

    // MARK: - test experimental

    func test_Capitalized() {
        // John Appleseed
        var user = User(firstName: "john", lastName: "appleseed")

        XCTAssertEqual("\(user.firstName) \(user.lastName)", "John Appleseed")

        // John Sundell
        user.lastName = "sundell"
        XCTAssertEqual("\(user.firstName) \(user.lastName)", "John Sundell")
    }

    class Example {
        var a = 0
        var b: String

        init(a: Int) { // Constructor
            self.a = a
            b = "name" // An error if a declared property isn't initialized
        }
    }

    @Weak var weakExamples: [Example]

    func xtest_WeakArray() {
        printClassAndFunc(info: "\(weakExamples)")

        weakExamples.append(Example(a: 42))
        printClassAndFunc(info: "\(weakExamples)")
        printClassAndFunc(info: "\(weakExamples.count)")

        weakExamples = [Example(a: 84)]
        printClassAndFunc(info: "\(weakExamples)")
        printClassAndFunc(info: "\(weakExamples.count)")
    }

    func test_UsingWrapper() {
        var using = UsingWrapper(x: 42)
        printClassAndFunc(info: "using= \(using)")
        printClassAndFunc(info: "using.x= \(using.x)")
        printClassAndFunc(info: "using.y= \(using.y)")

        using.x = 55
        printClassAndFunc(info: "using.x= \(using.x)")
    }

    func test_UsingWrapper2() {
        var using = UsingWrapper2(x: 42)
        printClassAndFunc(info: "using= \(using)")
        printClassAndFunc(info: "using.x= \(using.x)")
        printClassAndFunc(info: "using.y= \(using.y)")

        using.x = 55
        printClassAndFunc(info: "using.x= \(using.x)")
    }

    func test_UsingWrapper3() {
        var user = User3(first: 21, last: 82)
        XCTAssertEqual("\(user.first), \(user.last)", "63, 246")

        user.last = 164
        XCTAssertEqual("\(user.first), \(user.last)", "63, 492")
    }

    func test_UsingWrapper5() {
        let user = User5(first: Date())
        printClassAndFunc(info: "user= \(user)")
        printClassAndFunc(info: "user.first= \(user.first)")
    }

    func test_UsingPropertyWrappers2() {
        let date1 = Date()
        printClassAndFunc(info: "date1= \(date1)")

        var user = UsingPropertyWrappers2(first: [date1])
        printClassAndFunc(info: "user= \(user)")
        printClassAndFunc(info: "user.first= \(user.first)")

        user.first = [date1.incremented(by: .day, times: 1)]
        printClassAndFunc(info: "user.first= \(user.first)")

        user.first.append(date1.incremented(by: .hour, times: 7))
        printClassAndFunc(info: "user.first= \(user.first)")

        printClassAndFunc(info: "user.first[0]= \(user.first[0])")

        user.first.removeAll()
        printClassAndFunc(info: "user.first= \(user.first)")
    }
}

// MARK: - Property Wrappers: WholeMonth, WholeDay, WholeHours

// https://www.swiftbysundell.com/articles/property-wrappers-in-swift/

@propertyWrapper struct WholeMonth {
    var wrappedValue: Date { didSet { wrappedValue = wrappedValue.wholeMonth! } }
    init(wrappedValue: Date) { self.wrappedValue = wrappedValue.wholeMonth! }
}

@propertyWrapper struct WholeDay {
    var wrappedValue: Date { didSet { wrappedValue = wrappedValue.wholeDay! } }
    init(wrappedValue: Date) { self.wrappedValue = wrappedValue.wholeDay! }
}

@propertyWrapper struct WholeHours {
    private var storage = [Date]()
    var wrappedValue: [Date] {
        set { storage = newValue.map({ $0.wholeHour! }) }
        get { storage }
    }

    init(wrappedValue: [Date]) { storage = wrappedValue.map({ $0.wholeHour! }) }
}

struct UsingPropertyWrappers {
    @WholeMonth var yMonth: Date
    @WholeDay var ymDay: Date
    @WholeHours var ymdHours: [Date]

    init(date: Date) {
        yMonth = date
        ymDay = date
        ymdHours = []
    }
}

struct UsingPropertyWrappers2 {
    @WholeHours var first: [Date]
    // @Wrapper5 var last: Date
}

// MARK: -  experimental

// MARK: - Minimal Property Wrappers

// https://www.vadimbulavin.com/swift-5-property-wrappers/

@propertyWrapper
struct Wrapper<Value> {
    var wrappedValue: Value
}

struct UsingWrapper {
    @Wrapper var x: Int
    @Wrapper var y: Int = 84
}

@propertyWrapper
struct Wrapper2<Value: Numeric> {
    private var value: Value

    init(wrappedValue: Value) {
        value = wrappedValue
    }

    var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = newValue * newValue
        }
    }
}

struct UsingWrapper2 {
    @Wrapper var x: Int
    @Wrapper var y: Int = 84
}

// let a = UsingWrapper(x: 0)

@propertyWrapper
struct Atomic<Value> {
    private let queue = DispatchQueue(label: "com.vadimbulavin.atomic")
    private var value: Value

    init(wrappedValue: Value) {
        value = wrappedValue
    }

    var wrappedValue: Value {
        get {
            return queue.sync { value }
        }
        set {
            queue.sync { value = newValue }
        }
    }
}

@propertyWrapper struct Wrapper3 {
    var wrappedValue: Int {
        didSet { wrappedValue = wrappedValue * 3 }
    }

    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue * 3
    }
}

struct User3 {
    @Wrapper3 var first: Int
    @Wrapper3 var last: Int
}

@propertyWrapper struct Wrapper4 {
    var wrappedValue: Date {
        didSet { wrappedValue = wrappedValue.wholeDay! }
    }

    init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
    }
}

struct User4 {
    @Wrapper4 var first: Date
    @Wrapper4 var last: Date
}

@propertyWrapper struct Wrapper5 {
    var storage = [Date]()
    var wrappedValue: Date {
        set { storage.append(newValue.wholeHour!) }
        get { storage.first ?? Date() }
    }

    init(wrappedValue: Date) {
        storage.append(wrappedValue.wholeHour!)
    }
}

struct User5 {
    @Wrapper5 var first: Date
    // @Wrapper5 var last: Date
}

// MARK: - Using Private Storage

struct UsingPrivateStorage {
    private var _ymDay_private_storage: Date!
    var ymDay: Date {
        set { _ymDay_private_storage = newValue.wholeDay! }
        get { _ymDay_private_storage }
    }

    private var _yMonth_private_storage: Date!
    var yMonth: Date {
        set { _yMonth_private_storage = newValue.wholeMonth! }
        get { _yMonth_private_storage }
    }

    init(date: Date) {
        ymDay = date
        yMonth = date
    }
}

// MARK: - Using Property Wrappers: Capitalized

// https://www.swiftbysundell.com/articles/property-wrappers-in-swift/

@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct User {
    @Capitalized var firstName: String
    @Capitalized var lastName: String
}

// MARK: - Weak Arrays with Property Wrappers

// https://medium.com/@apstygo/implementing-weak-arrays-with-property-wrappers-in-swift-680e2b3c9fca

// Let’s first create an object wrapper:

final class WeakObject<T: AnyObject> {
    private(set) weak var value: T?
    init(_ v: T) { value = v }
}

@propertyWrapper
struct Weak<Element> where Element: AnyObject {
    private var storage = [WeakObject<Element>]()

    var wrappedValue: [Element] {
        get {
            storage.compactMap { $0.value }
        }
        set {
            storage = newValue.map { WeakObject($0) }
        }
    }
}

// @Weak private var weakViews: [UIView]

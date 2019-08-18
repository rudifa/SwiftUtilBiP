#  Swift BiPlatform utilities  &nbsp;&nbsp; ![travis badge](https://travis-ci.org/rudifa/SwiftUtilBiP.svg?branch=master)

by [rudifa](https://github.com/rudifa)

This project contains a set of utilities for use in Xcode projects that target one of or both **iOS** and **macOS** platforms.

## BiPlatformExtensions

`BiPlatformExtensions.swift` defines typealiases and extensions for a subset of `UIkit` | `Cocoa` classes and methods, to provide equivalent behaviors on both platforms. Typealiases use the prefix `NU` that aliases to `UI` on iOS and to `NS` on macOS.

Definition example

```
#if os(iOS)
    import UIKit
    typealias NUPanGestureRecognizer = UIPanGestureRecognizer
    ...
#elseif os(OSX)
    import Cocoa
    typealias NUPanGestureRecognizer = NSPanGestureRecognizer
    ...
#endif
```
Usage example
```
@objc func handlePan(recognizer: NUPanGestureRecognizer) {...}
```

## CGUtil

`CGUtil.swift` extends several CG structures and scalars with formatting and with arithmetic operations between CG structures and scalars.

```
let location = CGPoint(x: 123, y: 456)
print("loc= \(location.fmt)")
```
```
loc= (123.0, 456.0)
```

## DateUtil

`DateUtil.swift` extends class `Date` with formatting and time tag properties:
```
.ddMMyyyy
.HHmmss
.EEEEddMMyyyy
...
.timeTag
```

```
print("--- Today \(date.EEEEddMMyyyy) at \(date.HHmmss) tag= \(date.timeTag)")

--- Today Wednesday 07.08.2019 at 20:13:29 tag= 1565201609_57600
```

It also extends class `Date` with calendar-related methods and properties
```
.month
.nextMonth()
...
.isToday
```

```
var dd = Date()
print("--- \(dd.ddMMyyyy) is " + (dd.isToday ? "" : "not") + "today")
dd.nextMonth()
print("--- \(dd.ddMMyyyy) is " + (dd.isToday ? "" : "not ") + "today")

--- 07.08.2019 is today
--- 07.09.2019 is not today
```


## DebugUtil

`DebugUtil.swift` offers the method `printClassAndFunc(fnc:info)` for debugging purposes.
```
let location = CGPoint(x: 987, y: 654)
printClassAndFunc(info: "loc= \(location)")
```
```
---- ViewController.viewDidLoad() loc= (987.0, 654.0)
```


## DictUtil

`DictUtil.swift` declares a 2-tuple-like ```struct HashablePair<P1, P2>```
```
struct HashablePair<P1, P2>: Hashable where P1: Hashable, P2: Hashable {
    var p1: P1
    var p2: P2
    init(_ p1: P1, _ p2: P2) { self.p1 = p1; self.p2 = p2 }
}

```

which can be used to create a dictionary with that struct as a key. This is a partial workaround for the swift tuple not being useable as a dictionary key.

```
enum State { case black, red, green, blue }
enum Event { case done, cancel, reset }
typealias State_Event = HashablePair<State, Event>

let dictionary: Dictionary<State_Event, State> = [
    State_Event(.black, .cancel): .red,
    State_Event(.black, .done): .black,
    State_Event(.red, .cancel): .black,
}
```

## HexDump

`HexDump.swift` extends `String` with a simple property `.hexDump`


```
let string = "Hello Swift\t"
let hexdump = string.hexDump
print("---- \(string) \(hexdump)")

---- |Hello Swift	| |48 65 6c 6c 6f 20 53 77 69 66 74 09|
```
```
let string = "🇧🇷🇳🇿"
let hexdump = string.hexDump
print("---- \(string) \(hexdump)")

---- |flags 🇧🇷🇳🇿| |66 6c 61 67 73 20 1f1e7 1f1f7 1f1f3 1f1ff|

```


## NUConstraintsUtil

**`NUConstraintsUtil.swift`**  extends NUView (typealias for `UIView | NSView`) with method `addConstraintsWithFormat(format:options:metrics:views:)` that facilitates the use of Apple `Auto Layout Visual Format Language` in swift code.
```
view.addConstraintsWithFormat(format: "H:|-50-[v0(150)]-8-[v1(150)]", views: label1, label2)
```

## OptionalUtil

`OptionalUtil.swift` extends Optional so that an `Int?` can be freely incremented (defaults to 0 if nil)
```
var ival: Int?
ival.increment()
assert(ival == 1)

```

## RegexUtil

`RegexUtil.swift` extends class  String` with methods:
```
.matches(for regex: String) -> [String]
.isBlank() -> Bool
.doesMatch(regex: String) -> Bool
.extractUUID() -> String
```

```
var string = "🇩🇪€4.95"
var matched = string.matches(for: "[0-9]")
print("----", string, matched, "blank= \(string.isBlank())")

---- 🇩🇪€4.95 ["4", "9", "5"] blank= false
```


## StringUtil

`StringUtil.swift` extends `String` with property `.camelCaseSplit`

```
let string = "camelCaseSplit"
print("---- |\(string)| |\(string.camelCaseSplit)|")

---- |camelCaseSplit| |Camel Case Split|

```


## UIUtil.swift

`UIUtil.swift` (iOS only) extends UIAlertController with method `show() which presents the alert from a (possibly) non-UIViewController object.

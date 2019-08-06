#  Swift BiPlatform utilities

This project contains a set of utilities for use in Xcode projects that target one of or both **iOS** and **macOS** platforms.

## BiPlatformExtensions

**`BiPlatformExtensions.swift`** defines typealiases and extensions for a subset of `UIkit` | `Cocoa` classes and methods, to provide equivalent behaviors on both platforms. Typealiases use the prefix `NU` that aliases to `UI` on iOS and to `NS` on macOS.

```
#if os(iOS)
    import UIKit
    typealias NUPanGestureRecognizer = UIPanGestureRecognizer
    ...
#elseif os(OSX)
    import Cocoa
    typealias NUPanGestureRecognizer = UIPanGestureRecognizer
    ...
#endif
```
``` 
@objc func handlePan(recognizer: NUPanGestureRecognizer) {...}
```


## CGUtil

**`CGUtil.swift`** extends several CG structures and scalars with formatting and with arithmetic operations between CG structures and scalars.

``` 
let location = CGPoint(x: 123, y: 456)
print("loc= \(location)")
```
``` 
loc= (123.0, 456.0)
```

## DebugUtil
**`DebugUtil.swift`** offers the method `printClassAndFunc(fnc:info)` for debugging purposes.
``` 
let location = CGPoint(x: 987, y: 654)
printClassAndFunc(info: "loc= \(location)")
```
``` 
---- ViewController.viewDidLoad() loc= (987.0, 654.0)
```
## NUConstraintsUtil
**`NUConstraintsUtil.swift`**  extends NUView (typealias for `UIView | NSView`) with method `addConstraintsWithFormat(format:options:metrics:views:)` that facilitates the use of Apple `Auto Layout Visual Format Language` in swift code.
```
view.addConstraintsWithFormat(format: "H:|-50-[v0(150)]-8-[v1(150)]", views: label1, label2)
```


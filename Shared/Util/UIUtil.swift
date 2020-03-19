//
//  UIUtil.swift v.0.1.4
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 04.09.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

#if os(iOS)
    import UIKit

    /**
     Create a UIWindow with a UIViewController to present UIAlertController on it.
     from http://lazyself.io/ios/2017/05/18/present-uialertcontroller-when-not-in-a-uiviewcontroller.html
     */
    extension UIAlertController {
        /// present alert from a (possibly) non-UIViewController object
        func show() {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UIViewController()
            window.windowLevel = UIWindow.Level.alert
            window.makeKeyAndVisible()
            window.rootViewController?.present(self, animated: false, completion: nil)
        }
    }

    // https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
/// UIColor.init from a #rgba hex string like so:
///     let gold = UIColor(hex: "#ffe700ff")
    extension UIColor {
        public convenience init(hex: String) {
            let r, g, b, a: CGFloat

            if hex.hasPrefix("#") {
                let start = hex.index(hex.startIndex, offsetBy: 1)
                let hexColor = String(hex[start...])

                if hexColor.count == 8 {
                    let scanner = Scanner(string: hexColor)
                    var hexNumber: UInt64 = 0

                    if scanner.scanHexInt64(&hexNumber) {
                        r = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                        g = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                        b = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
                        a = CGFloat(hexNumber & 0x0000_00FF) / 255

                        self.init(red: r, green: g, blue: b, alpha: a)
                        return
                    }
                }
            }
            self.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }

#elseif os(OSX)
    // no macOS implementation
#endif

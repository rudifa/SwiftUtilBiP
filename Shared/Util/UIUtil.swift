//
//  UIUtil.swift v.0.1.3
//  Swift4Util
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

#elseif os(OSX)
    // no macOS implementation
#endif

//
//  AppDelegate.swift
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 28.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

#if os(iOS)

    import UIKit

    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?

        fileprivate func application(_: UIApplication, didFinishLaunchingWithOptions _: [NSObject: Any]?) -> Bool {
            // Override point for customization after application launch.
            return true
        }

        func applicationWillTerminate(_: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
    }

#elseif os(OSX)

    import Cocoa

    @NSApplicationMain
    class AppDelegate: NSObject, NSApplicationDelegate {
        func applicationDidFinishLaunching(_: Notification) {
            // Insert code here to initialize your application
        }

        func applicationWillTerminate(_: Notification) {
            // Insert code here to tear down your application
        }

        func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
            return true
        }
    }

#endif

//
//  ViewController.swift
//  BiPlatform
//
//  Created by Rudolf Farkas on 28.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

// https://www.raywenderlich.com/433-uigesturerecognizer-tutorial-getting-started
// https://cocoaosxrevisited.wordpress.com/2018/01/06/chapter-18-mouse-events/

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

class ViewController: NSUIViewController {
    var lastPanLocation = CGPoint()

    override func viewDidLoad() {
        super.viewDidLoad()
        printClassAndFunc()
        addGestureRecognizers()
    }
}

// MARK: - gesture recognizers

extension ViewController {
    private func addGestureRecognizers() {
        view.addGestureRecognizer(NSUITapClickGestureRecognizer(target: self,
                                                                action: #selector(handleTapClick(recognizer:))))
        view.addGestureRecognizer(NSUIPanGestureRecognizer(target: self,
                                                           action: #selector(handlePan(recognizer:))))
    }

    @objc func handleTapClick(recognizer: NSUITapClickGestureRecognizer) {
        let location = recognizer.locationFromTop(in: view)
        printClassAndFunc(info: "\(location.fmt)")
        // works on macOS and on iOS device, not on iOS simulator
    }

    @objc func handlePan(recognizer: NSUIPanGestureRecognizer) {
        let location = recognizer.locationFromTop(in: view)
        printClassAndFunc(info: "\(location.fmt)  \(recognizer.state.rawValue)")
        // works on macOS, on iOS device, and on iOS simulator
        let panSensitivity: Float = 5.0
        switch recognizer.state {
        case .began:
            lastPanLocation = location
        case .changed:
            _ = Float((lastPanLocation.x - location.x) / view.bounds.width) * panSensitivity
            _ = Float((lastPanLocation.y - location.y) / view.bounds.height) * panSensitivity
            // printClassAndFunc(info: "\(xDelta) \(yDelta) ")
            lastPanLocation = location
        case .ended:
            break
        default:
            break
        }
    }
}

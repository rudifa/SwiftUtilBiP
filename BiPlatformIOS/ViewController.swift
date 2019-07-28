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
    override func viewDidLoad() {
        super.viewDidLoad()
        printClassAndFunc()

        let tapClickRecognizer = NSUITapClickGestureRecognizer(target: self,
                                                               action: #selector(handleTapClick(recognizer:)))
        view.addGestureRecognizer(tapClickRecognizer)

        let panRecognizer = NSUIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        view.addGestureRecognizer(panRecognizer)
    }

    @objc func handleTapClick(recognizer: NSUITapClickGestureRecognizer) {
        let location = recognizer.locationFromTop(in: view)
        printClassAndFunc(info: "\(location)")
    }

    @objc func handlePan(recognizer: NSUIPanGestureRecognizer) {
        let location = recognizer.locationFromTop(in: view)
        printClassAndFunc(info: "\(location)")
    }
}

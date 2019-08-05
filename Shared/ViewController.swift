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

//https://www.hackingwithswift.com/example-code/uikit/how-to-create-auto-layout-constraints-in-code-constraintswithvisualformat

class ViewController: NSUIViewController {
    var lastPanLocation = CGPoint()

    override func viewDidLoad() {
        super.viewDidLoad()
        printClassAndFunc()
        addGestureRecognizers()




        let label1 = NSUILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = NSUIColor.red
        label1.text = "THESE"
        label1.sizeToFit()

        let label2 = NSUILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = NSUIColor.cyan
        label2.text = "ARE"
        label2.sizeToFit()

        let label3 = NSUILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = NSUIColor.yellow
        label3.text = "SOME"
        label3.sizeToFit()

        let label4 = NSUILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = NSUIColor.green
        label4.text = "AWESOME"
        label4.sizeToFit()

        let label5 = NSUILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = NSUIColor.orange
        label5.text = "LABELS"
        label5.sizeToFit()
        printClassAndFunc(info: "l5 \(label5.text)")

        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)

        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]

        for label in viewsDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
        }

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))

    }

}

// MARK: - gesture recognizers

extension ViewController: NSUIGestureRecognizerDelegate {
    private func addGestureRecognizers() {
        let tapClickGestureRecognizer = NSUITapClickGestureRecognizer(target: self,
                                                                      action: #selector(handleTapClick(recognizer:)))
        let panGestureRecognizer = NSUIPanGestureRecognizer(target: self,
                                                            action: #selector(handlePan(recognizer:)))
        tapClickGestureRecognizer.delegate = self
        panGestureRecognizer.delegate = self

        view.addGestureRecognizer(tapClickGestureRecognizer)
        view.addGestureRecognizer(panGestureRecognizer)
    }

    //    Controlling Simultaneous Gesture Recognition
    //    func gestureRecognizer(UIGestureRecognizer, shouldRecognizeSimultaneouslyWith: UIGestureRecognizer) -> Bool
    //    Asks the delegate if two gesture recognizers should be allowed to recognize gestures simultaneously.

    func gestureRecognizer(_: NSUIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: NSUIGestureRecognizer) -> Bool {
        printClassAndFunc()
        return true
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

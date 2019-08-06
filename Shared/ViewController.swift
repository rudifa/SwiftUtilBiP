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

// https://www.hackingwithswift.com/example-code/uikit/how-to-create-auto-layout-constraints-in-code-constraintswithvisualformat
// https://stackoverflow.com/questions/26180822/how-to-add-constraints-programmatically-using-swift

class ViewController: NSUIViewController {
    var lastPanLocation = CGPoint()

    lazy var label1: NSUILabel = {
        let label = NSUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = NSUIColor.yellow
        label.text = "Pan from"
        label.sizeToFit()
        return label
    }()

    lazy var label2: NSUILabel = {
        let label = NSUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = NSUIColor.yellow
        label.text = ""
        label.sizeToFit()
        return label
    }()

    lazy var label3: NSUILabel = {
        let label = NSUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = NSUIColor.yellow
        label.text = "to"
        label.sizeToFit()
        return label
    }()

    lazy var label4: NSUILabel = {
        let label = NSUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = NSUIColor.yellow
        label.text = ""
        label.sizeToFit()
        return label
    }()

    lazy var label5: NSUILabel = {
        let label = NSUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = NSUIColor.orange
        label.text = "TapClick at"
        label.sizeToFit()
        return label
    }()

    lazy var label6: NSUILabel = {
        let label = NSUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = NSUIColor.orange
        label.text = ""
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        printClassAndFunc()
        addGestureRecognizers()

        addLabels()
    }

    fileprivate func addLabels() {

        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        view.addSubview(label6)


        view.addConstraintsWithFormat(format: "H:|-50-[v0(150)]-8-[v1(150)]", views: label1, label2)
        view.addConstraintsWithFormat(format: "V:|-100-[v0]", views: label1)
        view.addConstraintsWithFormat(format: "V:|-100-[v0]", views: label2)

        view.addConstraintsWithFormat(format: "H:|-50-[v0(150)]-8-[v1(150)]", views: label3, label4)
        view.addConstraintsWithFormat(format: "V:|-150-[v0]", views: label3)
        view.addConstraintsWithFormat(format: "V:|-150-[v0]", views: label4)

        view.addConstraintsWithFormat(format: "H:|-50-[v0(150)]-8-[v1(150)]", views: label5, label6)
        view.addConstraintsWithFormat(format: "V:|-250-[v0]", views: label5)
        view.addConstraintsWithFormat(format: "V:|-250-[v0]", views: label6)
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
        label6.text = "\(location.fmt)"
    }

    @objc func handlePan(recognizer: NSUIPanGestureRecognizer) {
        let location = recognizer.locationFromTop(in: view)
        printClassAndFunc(info: "\(location.fmt)  \(recognizer.state.rawValue)")
        // works on macOS, on iOS device, and on iOS simulator
        let panSensitivity: Float = 5.0
        switch recognizer.state {
        case .began:
            lastPanLocation = location
            label2.text = "\(lastPanLocation.fmt)"
        case .changed:
            _ = Float((lastPanLocation.x - location.x) / view.bounds.width) * panSensitivity
            _ = Float((lastPanLocation.y - location.y) / view.bounds.height) * panSensitivity
            // printClassAndFunc(info: "\(xDelta) \(yDelta) ")
            lastPanLocation = location
            label4.text = "\(lastPanLocation.fmt)"
        case .ended:
            break
        default:
            break
        }
    }
}

//
//  BiPlatformExtensions.swift v.0.1.0
//  SwiftUtil
//
//  Created by Rudolf Farkas on 27.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

#if os(iOS)
    import UIKit
    typealias NSUIViewController = UIViewController
    typealias NSUIGestureRecognizer = UIGestureRecognizer
    typealias NSUIPanGestureRecognizer = UIPanGestureRecognizer
    typealias NSUITapClickGestureRecognizer = UITapGestureRecognizer

    func positiveDeltaIsDownwards(delta: Float) -> Float { return delta }
#elseif os(OSX)
    import Cocoa
    typealias NSUIViewController = NSViewController
    typealias NSUIGestureRecognizer = NSGestureRecognizer
    typealias NSUIPanGestureRecognizer = NSPanGestureRecognizer
    typealias NSUITapClickGestureRecognizer = NSClickGestureRecognizer
    func positiveDeltaIsDownwards(delta: Float) -> Float { return -delta }
#endif

#if os(iOS)
    extension NSUIViewController {
        open override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
            if let location = touches.first?.location(in: view) {
//                handleInteraction(at: location)
            }
        }
    }
    extension UIGestureRecognizer {
        func locationFromTop(in view: UIView) -> CGPoint {
            return location(in: view)
        }
    }
#elseif os(OSX)
    extension NSUIViewController {
        open override func mouseDown(with event: NSEvent) {
            var location = view.convert(event.locationInWindow, from: nil)
            location.y = view.bounds.height - location.y // Flip from AppKit default window coordinates to Metal viewport coordinates
//            handleInteraction(at: location)
        }
    }
extension NSGestureRecognizer {
    func locationFromTop(in view: NSView) -> CGPoint {
        var location = self.location(in: view)
        location.y = view.bounds.height - location.y
        return location
    }
}
#endif

#if os(iOS)
    typealias NSUIImage = UIImage
#elseif os(OSX)
    typealias NSUIImage = NSImage
    extension NSImage {
        convenience init(cgImage: CGImage) {
            self.init(cgImage: cgImage, size: CGSize(width: cgImage.width, height: cgImage.height))
        }

        var cgImage: CGImage? {
            return self.cgImage(forProposedRect: nil, context: nil, hints: nil)
        }
    }
#endif

//
//  BiPlatformExtensions.swift v.0.1.4
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
    typealias NSUIGestureRecognizerDelegate = UIGestureRecognizerDelegate
    typealias NSUILabel = UILabel
    typealias NSUIColor = UIColor
    typealias NSUIStackView = UIStackView
    typealias NUView = UIView

#elseif os(OSX)
    import Cocoa
    typealias NSUIViewController = NSViewController
    typealias NSUIGestureRecognizer = NSGestureRecognizer
    typealias NSUIPanGestureRecognizer = NSPanGestureRecognizer
    typealias NSUITapClickGestureRecognizer = NSClickGestureRecognizer
    typealias NSUIGestureRecognizerDelegate = NSGestureRecognizerDelegate
    typealias NSUILabel = NSTextField
    typealias NSUIColor = NSColor
    typealias NSUIStackView = NSStackView
    typealias NUView = NSView

#endif

#if os(iOS)
    extension UIGestureRecognizer {
        func locationFromTop(in view: UIView) -> CGPoint {
            return location(in: view)
        }
    }

#elseif os(OSX)
    extension NSGestureRecognizer {
        func locationFromTop(in view: NSView) -> CGPoint {
            var location = self.location(in: view)
            location.y = view.bounds.height - location.y
            return location
        }
    }

    extension NSTextField {
        var text: String {
            set {
                isEditable = false
                isBezeled = false
                stringValue = newValue
            }
            get {
                return stringValue
            }
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

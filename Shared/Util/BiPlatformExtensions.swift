//
//  BiPlatformExtensions.swift v.0.2.0
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 27.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

#if os(iOS)
    import UIKit

    typealias NUColor = UIColor
    typealias NUGestureRecognizer = UIGestureRecognizer
    typealias NUGestureRecognizerDelegate = UIGestureRecognizerDelegate
    typealias NUPanGestureRecognizer = UIPanGestureRecognizer
    typealias NUTapClickGestureRecognizer = UITapGestureRecognizer
    typealias NULabel = UILabel
    typealias NUStackView = UIStackView
    typealias NUView = UIView
    typealias NUViewController = UIViewController

#elseif os(OSX)
    import Cocoa

    typealias NUColor = NSColor
    typealias NUGestureRecognizer = NSGestureRecognizer
    typealias NUGestureRecognizerDelegate = NSGestureRecognizerDelegate
    typealias NUPanGestureRecognizer = NSPanGestureRecognizer
    typealias NUTapClickGestureRecognizer = NSClickGestureRecognizer
    typealias NULabel = NSTextField
    typealias NUStackView = NSStackView
    typealias NUView = NSView
    typealias NUViewController = NSViewController

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
            get { return stringValue }
            set { isEditable = false
                isBezeled = false
                stringValue = newValue }
        }

        var textAlignment: NSTextAlignment {
            get { return alignment }
            set { alignment = newValue }
        }
    }
#endif

#if os(iOS)
    typealias NUImage = UIImage
#elseif os(OSX)
    typealias NUImage = NSImage
    extension NSImage {
        convenience init(cgImage: CGImage) {
            self.init(cgImage: cgImage, size: CGSize(width: cgImage.width, height: cgImage.height))
        }

        var cgImage: CGImage? {
            return self.cgImage(forProposedRect: nil, context: nil, hints: nil)
        }
    }
#endif

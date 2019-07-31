//
//  CGUtil.swift v.0.1.2
//  Swift4Util
//
//  Created by Rudolf Farkas on 31.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

// Formatting

extension CGFloat {
    var fmt: String { return String(format: "%.3g", self) }
}

extension CGPoint {
    var fmt: String { return String(format: "(%.2f, %.2f)", x, y) }
}

extension CGSize {
    var fmt: String { return String(format: "(%.2f, %.2f)", width, height) }
}

extension CGRect {
    var fmt: String { return "\(origin.fmt),\(size.fmt)" }
}

// Arithmetic operations

extension CGSize {
    static func * (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width * scalar, height: size.height * scalar)
    }

    static func * (size: CGSize, scalar: Double) -> CGSize {
        return size * CGFloat(scalar)
    }

    static func / (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width / scalar, height: size.height / scalar)
    }

    static func / (size: CGSize, scalar: Double) -> CGSize {
        return size / CGFloat(scalar)
    }
}

extension CGPoint {
    static func * (size: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: size.x * scalar, y: size.y * scalar)
    }

    static func * (size: CGPoint, scalar: Double) -> CGPoint {
        return size * CGFloat(scalar)
    }

    static func / (size: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: size.x / scalar, y: size.y / scalar)
    }

    static func / (size: CGPoint, scalar: Double) -> CGPoint {
        return size / CGFloat(scalar)
    }
}

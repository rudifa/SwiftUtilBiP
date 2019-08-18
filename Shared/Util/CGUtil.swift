//
//  CGUtil.swift v.0.1.2
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 31.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

// MARK: - Formatting of CG structures and scalars

extension CGFloat {
    /// Returns a "%.3g" formatted string
    var fmt: String { return String(format: "%.3g", self) }
}

extension CGPoint {
    /// Returns a pair of "%.2f" formatted strings
    var fmt: String { return String(format: "(%.2f, %.2f)", x, y) }
}

extension CGSize {
    /// Returns a pair of "%.2f" formatted strings
    var fmt: String { return String(format: "(%.2f, %.2f)", width, height) }
}

extension CGRect {
    /// Returns a quad of "%.2f" formatted strings
    var fmt: String { return "\(origin.fmt),\(size.fmt)" }
}

// MARK: - Arithmetic operations between CG structures and scalars

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

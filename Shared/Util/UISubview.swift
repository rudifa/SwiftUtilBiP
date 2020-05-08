//
//  UISubview.swift
//  QRCodeGenerator
//
//  Created by Rudolf Farkas on 18.03.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import UIKit

extension UIView {
    enum AnchorX {
        case center // pos
        case full   // pos+width
        case prop(mult: CGFloat) // width
    }

    enum Anchor {
        case center
        case full
        case prop(mult: CGFloat)
    }

    func addSubview(sub: UIView, x: AnchorX, y: Anchor, w: Anchor, h: Anchor) {
        addSubview(sub)
        var constraints = [NSLayoutConstraint]()

        switch x {
        case .full:
            constraints.append(sub.widthAnchor.constraint(equalTo: widthAnchor))
        case let .prop(mult):
            constraints.append(sub.widthAnchor.constraint(equalTo: widthAnchor, multiplier: mult))
        case .center: fallthrough
        default:
            constraints.append(sub.centerXAnchor.constraint(equalTo: centerXAnchor))
        }

        switch w {
        case .full:
            constraints.append(sub.widthAnchor.constraint(equalTo: widthAnchor))
        case let .prop(mult):
            constraints.append(sub.widthAnchor.constraint(equalTo: widthAnchor, multiplier: mult))
        case .center: fallthrough
        default:
            constraints.append(sub.centerXAnchor.constraint(equalTo: centerXAnchor))
        }
        // NSLayoutConstraint.activate([])
    }
}

//
//  NUConstraintsUtil.swift v.0.1.0
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 06.08.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

// from https://blog.flashgen.com/2016/10/auto-layout-visual-format-language-helpers/

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

/** Originally from https://blog.flashgen.com/2016/10/auto-layout-visual-format-language-helpers/

Usage example
    self.addConstraintsWithFormat(format: "H:|-8-[v0(100)]-8-[v1(>=20)]-8-[v2(100)]-8-|", views: previousButton, pageControl, nextButton)
 */
extension NUView {
    /// Add constraints on views using the Auto Layout Visual Format Language
    ///
    /// - Parameters:
    ///   - format: string describing constraints in VFL
    ///   - options: alignement, direction, spacing
    ///   - metrics: a dict of constants for use in format
    ///   - views: views to constrain
    func addConstraintsWithFormat(format: String, options: NSLayoutConstraint.FormatOptions = [], metrics: [String : NSNumber]? = nil, views: NUView...) {
        var viewDictionary = [String: NUView]()

        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: [],
                                                      metrics: [:],
                                                      views: viewDictionary))
    }
}

//
//  NUConstraintsUtil.swift v.0.1.0
//  SwiftUtilBiPIOS
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

/* Example
 self.addConstraintsWithFormat(format: "H:|-8-[v0(100)]-8-[v1(>=20)]-8-[v2(100)]-8-|", views: previousButton, pageControl, nextButton)
 */

//open class func constraints(withVisualFormat format: String, options opts: NSLayoutConstraint.FormatOptions = [], metrics: [String : NSNumber]?, views: [String : Any]) -> [NSLayoutConstraint]


extension NUView {
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

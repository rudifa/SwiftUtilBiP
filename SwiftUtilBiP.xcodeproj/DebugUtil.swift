//
//  DebuggingUtil.swift  v.0.2.0
//  Swift4Util
//
//  Created by Rudolf Farkas on 23.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import Foundation

extension NSObject {
    /// print current class and function names, optionally info
    func printClassAndFunc(fnc fnc_: String = #function, info inf_: String = "") {
        #if DEBUG
        print("---- \(String(describing: type(of: self))).\(fnc_)", inf_)
        #endif
    }
}

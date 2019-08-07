//
//  StringUtil.swift v.0.2.0
//  Swift4Util
//
//  Created by Rudolf Farkas on 22.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }

    /// Capitalizes 1st letter and inserts a space before any other capital letter
    var camelCaseSplit: String {
        var newString: String = prefix(1).capitalized
        for char in dropFirst() {
            if "A" ... "Z" ~= char, newString != "" {
                newString.append(" ")
            }
            newString.append(char)
        }
        return newString
    }
}

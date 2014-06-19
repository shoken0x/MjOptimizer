//
//  String+Substring.swift
//  MjOptimizer
//
//  Created by Shoken Fujisaki on 6/16/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import Foundation
extension String {
//    duplicate with ExSwift
//    func length () -> Int {
//        return (countElements (self))
//    }
//    subscript(r: Range<Int>) -> String {
//        return self.substring(from: r.startIndex, length: (r.endIndex - r.startIndex))
//    }
    
    func substring (from: Int, _ length: Int) -> String {
        let intermediate = self.substringFromIndex (from)
        return intermediate.substringToIndex(length)
    }
    
    func substringAt (index: Int) -> String {
        return self.substring(index, 1)
    }
    
    func remove (from: Int, _ length: Int) -> String {
        let left    =   self.substringToIndex(from)
        let right   =   self.substringFromIndex(from + length)
        return (left + right)
    }
    
    func removeCharAt (index: Int) -> String {
        return self.remove (index, 1)
    }
}
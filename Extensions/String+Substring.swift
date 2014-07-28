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
    
    func substring (var from: Int, _ length: Int) -> String {
        var fromIndex = self.startIndex
        while(from > 0) {
            fromIndex = fromIndex.successor()
            from = from - 1
        }
        let intermediate = self.substringFromIndex (fromIndex)
        
        var toIndex = intermediate.startIndex
        var l = length
        while(l > 0) {
            toIndex = toIndex.successor()
            l = l - 1
        }
        return intermediate.substringToIndex(toIndex)
    }
    
    func substringAt (index: Int) -> String {
        return self.substring(index, 1)
    }
    
    func remove (var from: Int, _ length: Int) -> String {
        var fromIndex = self.startIndex
        while(from > 0) {
            fromIndex = fromIndex.successor()
            from = from - 1
        }
        let left    =   self.substringToIndex(fromIndex)
        
        var toIndex = fromIndex
        var l = length
        while(l > 0) {
            toIndex = toIndex.successor()
            l = l - 1
        }

        let right   =   self.substringFromIndex(toIndex)
        return (left + right)
    }
    
    func removeCharAt (index: Int) -> String {
        return self.remove (index, 1)
    }
}
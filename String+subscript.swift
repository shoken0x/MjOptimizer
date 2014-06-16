//
//  String+subscript.swift
//  MjOptimizer
//
//  Created by gino on 2014/06/16.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

extension String {
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = advance(self.startIndex, r.startIndex)
            println(startIndex)
            let endIndex = advance(self.startIndex, r.endIndex - r.startIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}
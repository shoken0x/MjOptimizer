//
//  String+slice_with.swift
//  MjOptimizer
//
//  Created by gino on 2014/06/17.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

extension String {
    func sliceWith(let n: Int) -> Array<String> {
        assert(n > 0)
        
        var result = Array<String>()
        var idx = 1
        var str = ""
        for char in self {
            str += char
            if idx % n == 0 {
                result.append(str)
                str = ""
            }
            idx++
        }
        if countElements(str) > 0 {
            result.append(str)
        }
        return result
    }
}
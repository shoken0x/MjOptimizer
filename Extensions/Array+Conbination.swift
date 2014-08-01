//
//  Array+Conbination.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/31.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

extension Array {
    func conbination() -> Array<Array> {
        var ret = Array<Array>()
        for var i=0;i<count;i++ {
            for var j=i+1;j<count;j++ {
                ret.append([self[i],self[j]])
            }
        }
        return ret
    }
    func tripleConbination() -> Array<Array> {
        var ret = Array<Array>()
        for var i=0;i<count;i++ {
            for var j=i+1;j<count;j++ {
                for var k=j+1;k<count;k++ {
                    ret.append([self[i],self[j],self[k]])
                }
            }
        }
        return ret
    }
    func copy() -> Array{
        var ret = Array()
        for ele in self{
            ret.append(ele)
        }
        return ret
    }
}
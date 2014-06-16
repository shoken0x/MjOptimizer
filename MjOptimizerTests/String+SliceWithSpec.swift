//
//  String+SliceWithSpec.swift
//  MjOptimizer
//
//  Created by gino on 2014/06/17.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

import MjOptimizer
import Quick

class StringSliceWithSpec: QuickSpec {
    override func exampleGroups() {
        describe("sliceWith") {
            it("slice string to array") {
                expect("abcdefhij".sliceWith(3)).to.equal(["abc", "def", "hij"])
            }
            
            it("returns empty array when string is empty") {
                expect("".sliceWith(3)).to.equal([])
            }
            
            it("returns array with single string when argument is larger than string length") {
                expect("short".sliceWith(10)).to.equal(["short"])
            }
        }
    }
}

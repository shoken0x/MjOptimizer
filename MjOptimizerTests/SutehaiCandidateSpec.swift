//
//  SutehaiCandidateSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class SutehaiCandidateSpec: QuickSpec {
    override func spec() {
        describe("SutehaiCandidate") {
            beforeEach { }
            describe("#init"){
                it("create") {
                    var sc:SutehaiCandidate = SutehaiCandidate(
                        pai:Pai.parse("m1t")!,
                        ukeirePaiList:[
                            UkeirePai(pai: Pai.parse("m2t")!,remainNum: 4),
                            UkeirePai(pai: Pai.parse("m5t")!,remainNum: 5)
                        ],
                        shantenNum:3,
                        positionIndex:2
                    )
                    expect(sc.getUkeireTotalNum()).to(equal(9))
                }
            }
        }
    }
}
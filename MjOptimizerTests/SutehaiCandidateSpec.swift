//
//  SutehaiCandidateSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

import MjOptimizer
import Quick

class SutehaiCandidateSpec: QuickSpec {
    override func exampleGroups() {
        describe("SutehaiCandidate") {
            beforeEach { }
            it("init") {
                var sc:SutehaiCandidate = SutehaiCandidate(
                    pai:Pai(paiStr: "m1t"),
                    ukeirePaiList:[
                        UkeirePai(pai: Pai(paiStr:"m2t"),remainNum: 4),
                        UkeirePai(pai: Pai(paiStr:"m5t"),remainNum: 5)
                    ],
                    shantenNum:3,
                    positionIndex:2
                )
                expect(sc.getUkeireTotalNum()).to.equal(9)
            }
        }
    }
}
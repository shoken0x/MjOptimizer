//
//  UkeirePaiSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick

class UkeirePaiSpec: QuickSpec {
    override func exampleGroups() {
        describe("UkeirePai Class") {
            beforeEach { }
            it("init") {
                var upai:UkeirePai = UkeirePai(pai: Pai(paiStr: "m1t"),remainNum: 4)
                expect(upai.getRemainNum()).to.equal(4)
            }
        }
    }
}

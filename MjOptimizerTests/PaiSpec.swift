//
//  PaiSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/14.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick

class PaiSpec: QuickSpec {
    override func exampleGroups() {
        describe("Pai Class") {
            beforeEach { }
            it("init1") {
                var pai:Pai = Pai(type: PaiType.MANZU,number: 1,direction: PaiDirection.TOP)
                //expect(pai.type).to.equal(PaiType.MANZU)
                expect(pai.getTypeStr()).to.equal("m")
                expect(pai.number).to.equal(1)
                //expect(pai.direction).to.equal(PaiDirection.TOP)
                expect(pai.getDirectionStr()).to.equal("t")
                expect(pai.toString()).to.equal("m1t")
            }
            it("init2") {
                var pai:Pai = Pai(paiStr: "u1t")
                //expect(pai.type).to.equal(PaiType.MANZU)
                expect(pai.getTypeStr()).to.equal("m")
                expect(pai.number).to.equal(1)
                //expect(pai.direction).to.equal(PaiDirection.TOP)
                expect(pai.getDirectionStr()).to.equal("t")
                expect(pai.toString()).to.equal("m1t")
            }
        }
    }
}

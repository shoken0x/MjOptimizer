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
                var pai:Pai = Pai(type: PaiType.MANZU,number: 1,direction: PaiDirection.LEFT)
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.getType() == PaiType.MANZU).to.beTrue()
                expect(pai.getTypeStr()).to.equal("m")
                
                expect(pai.number).to.equal(1)
                expect(pai.getNumber()).to.equal(1)
                
                expect(pai.direction == PaiDirection.LEFT).to.beTrue()
                expect(pai.getDirection() == PaiDirection.LEFT).to.beTrue()
                expect(pai.getDirectionStr()).to.equal("l")
                
                expect(pai.toString()).to.equal("m1l")
            }
            it("init2") {
                var pai:Pai = Pai(type: PaiType.MANZU,number: 1)
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.getType() == PaiType.MANZU).to.beTrue()
                expect(pai.getTypeStr()).to.equal("m")
                
                expect(pai.number).to.equal(1)
                expect(pai.getNumber()).to.equal(1)
                
                expect(pai.direction == PaiDirection.TOP).to.beTrue()
                expect(pai.getDirection() == PaiDirection.TOP).to.beTrue()
                expect(pai.getDirectionStr()).to.equal("t")
                
                expect(pai.toString()).to.equal("m1t")
            }
            it("init3") {
                var pai:Pai = Pai(paiStr: "m1t")
                
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.getType() == PaiType.MANZU).to.beTrue()
                expect(pai.getTypeStr()).to.equal("m")
                
                expect(pai.number).to.equal(1)
                expect(pai.getNumber()).to.equal(1)
                
                expect(pai.direction == PaiDirection.TOP).to.beTrue()
                expect(pai.getDirection() == PaiDirection.TOP).to.beTrue()
                expect(pai.getDirectionStr()).to.equal("t")
                
                expect(pai.toString()).to.equal("m1t")
            }
        }
    }
}

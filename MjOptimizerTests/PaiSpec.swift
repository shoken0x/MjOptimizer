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
        describe("init") {
            beforeEach { }
            it("1") {
                var pai:Pai = Pai(type: PaiType.MANZU,number: 1,direction: PaiDirection.LEFT)
                
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.number).to.equal(1)
                expect(pai.direction == PaiDirection.LEFT).to.beTrue()
                expect(pai.toString()).to.equal("m1l")
            }
            it("2") {
                var pai:Pai = Pai(type: PaiType.MANZU,number: 1)
                
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.number).to.equal(1)
                expect(pai.direction == PaiDirection.TOP).to.beTrue()
                expect(pai.toString()).to.equal("m1t")
            }
            
            it("3") {
                var pai:Pai = Pai.parse("m1l")!
                
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.number).to.equal(1)
                expect(pai.direction == PaiDirection.LEFT).to.beTrue()
                expect(pai.toString()).to.equal("m1l")
            }
            
            it("init3") {
                var pai:Pai = Pai.parse("m1t")!
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.number).to.equal(1)
                expect(pai.direction == PaiDirection.TOP).to.beTrue()
                expect(pai.toString()).to.equal("m1t")
            }
        }
        describe("stringToPaiList"){
            it("1"){
                //var paiList:Pai[] = Pai.stringToPaiList("s2lm1tp5t")!
                //expect(paiList[0].toString()).to.equal("s2l")
                //expect(paiList[1].toString()).to.equal("m1t")
                //expect(paiList[2].toString()).to.equal("p5t")
            }
        }
    }
}

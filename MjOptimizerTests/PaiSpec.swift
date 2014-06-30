//
//  PaiSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/14.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class PaiSpec: QuickSpec {
    override func spec() {
        describe("init") {
            beforeEach { }
            it("takes 3 arguments and create Pai instance") {
                var pai:Pai = Pai(type: PaiType.MANZU,number: 1,direction: PaiDirection.LEFT)
                
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.number).to.equal(1)
                expect(pai.direction == PaiDirection.LEFT).to.beTrue()
                expect(pai.toString()).to.equal("m1l")
            }
            it("can omit direction argument") {
                var pai:Pai = Pai(type: PaiType.MANZU,number: 1)
                
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.number).to.equal(1)
                expect(pai.direction == PaiDirection.TOP).to.beTrue()
                expect(pai.toString()).to.equal("m1t")
            }
        }
        
        describe("#parse") {
            it("parses the string which match with MJ protocol") {
                var pai:Pai = Pai.parse("m1l")!
                
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.number).to.equal(1)
                expect(pai.direction == PaiDirection.LEFT).to.beTrue()
                expect(pai.toString()).to.equal("m1l")
            }
            
            it("returns nil when specified string does not match with MJ protocol") {
                if let pai = Pai.parse("detarame") {
                    // should not come to this place
                    expect(true).to.equal(false)
                } else {
                    // should come to this place
                    expect(true).to.equal(true)
                }
            }
        }
        describe("#parseList"){
            it("returns array of Pai"){
                let paiList:Pai[] = Pai.parseList("s2lm1tp5t")!
                expect(paiList[0].toString()).to.equal("s2l")
                expect(paiList[1].toString()).to.equal("m1t")
                expect(paiList[2].toString()).to.equal("p5t")
            }
        }
        describe("#toEqual"){
            it("return bool"){
                let pai = Pai.parse("s2l")!
                expect(pai.equal(Pai.parse("s2l")!)).to.beTrue()
                expect(pai.equal(Pai.parse("s3l")!)).to.beFalse()
            }
        }
        describe("Equatable"){
            it("return Bool"){
                let pai1 = Pai.parse("s1l")!
                let pai2 = Pai.parse("s1t")!
                let pai3 = Pai.parse("s2l")!
                expect(pai1 == pai2).to.beTrue()
                expect(pai1 == pai3).to.beFalse()
                expect(pai1 === pai1).to.beTrue()
                expect(pai1 === pai2).to.beFalse()
            }
        }
    }
}

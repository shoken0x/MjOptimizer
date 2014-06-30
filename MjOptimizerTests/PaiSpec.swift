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
            it("takes 3 arguments and create Pai instance") {
                var pai:Pai = Pai(type: PaiType.REVERSE,number: 1,direction: PaiDirection.LEFT)
                
                expect(pai.type == PaiType.MANZU).to.beTrue()
                expect(pai.number).to.equal(1)
                expect(pai.direction == PaiDirection.LEFT).to.beTrue()
                expect(pai.toString()).to.equal("r1l")
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
        describe("<"){
            it("return true"){
                expect(Pai.parse("s1t")! < Pai.parse("s2t")!).to.beTrue()
            }
            it("return false"){
                expect(Pai.parse("s3t")! < Pai.parse("s2t")!).to.beFalse()
                expect(Pai.parse("s3t")! < Pai.parse("j2t")!).to.beFalse()
            }
        }
        describe(">"){
            it("return true"){
                expect(Pai.parse("s2t")! > Pai.parse("s1t")!).to.beTrue()
            }
            it("return false"){
                expect(Pai.parse("s1t")! > Pai.parse("s2t")!).to.beFalse()
                expect(Pai.parse("s3t")! > Pai.parse("j2t")!).to.beFalse()
            }
            it("shuld be sorted"){
                let paiList:Pai[] = Pai.parseList("m2tm1tm4t")!
                let sorted = sort(paiList,>)
                expect(sorted[0].toString()).to.equal("m4t")
                expect(sorted[1].toString()).to.equal("m2t")
                expect(sorted[2].toString()).to.equal("m1t")
            }
        }
        describe("=="){
            it("return true"){
                expect(Pai.parse("s2t")! == Pai.parse("s2t")!).to.beTrue()
            }
            it("return false"){
                expect(Pai.parse("s1t")! == Pai.parse("s2t")!).to.beFalse()
            }
        }
        describe("!="){
            it("return true"){
                expect(Pai.parse("s2t")! != Pai.parse("s1t")!).to.beTrue()
            }
            it("return false"){
                expect(Pai.parse("s2t")! != Pai.parse("s2t")!).to.beFalse()
            }
        }
        describe("isJihai"){
            it("works"){
                expect(Pai.parse("j1t")!.isJihai()).to.beTrue()
                expect(Pai.parse("m1t")!.isJihai()).to.beFalse()
                expect(Pai.parse("s1t")!.isJihai()).to.beFalse()
                expect(Pai.parse("p1t")!.isJihai()).to.beFalse()
                expect(Pai.parse("r1t")!.isJihai()).to.beFalse()
            }
        }
        describe("isShupai"){
            it("works"){
                expect(Pai.parse("j1t")!.isShupai()).to.beFalse()
                expect(Pai.parse("m1t")!.isShupai()).to.beTrue()
                expect(Pai.parse("s1t")!.isShupai()).to.beTrue()
                expect(Pai.parse("p1t")!.isShupai()).to.beTrue()
                expect(Pai.parse("r1t")!.isShupai()).to.beFalse()
            }
        }
        describe("isYaochu"){
            it("works"){
                expect(Pai.parse("j2t")!.isYaochu()).to.beTrue()
                expect(Pai.parse("j1t")!.isYaochu()).to.beTrue()
                expect(Pai.parse("s1t")!.isYaochu()).to.beTrue()
                expect(Pai.parse("s9t")!.isYaochu()).to.beTrue()
                expect(Pai.parse("p1t")!.isYaochu()).to.beTrue()
                expect(Pai.parse("p9t")!.isYaochu()).to.beTrue()
                expect(Pai.parse("s2t")!.isYaochu()).to.beFalse()
                expect(Pai.parse("r1t")!.isYaochu()).to.beFalse()
            }
        }
        describe("next"){
            it("returns next pai"){
                expect(Pai.parse("s1t")!.next()!.toString()).to.equal("s2t")
                expect(Pai.parse("s1t")!.next(range:1)!.toString()).to.equal("s2t")
                expect(Pai.parse("s1t")!.next(range: 2)!.toString()).to.equal("s3t")
            }
            it("returns nil"){
                expect(Pai.parse("j1t")!.next() == nil ).to.beTrue()
                expect(Pai.parse("r1t")!.next() == nil ).to.beTrue()
                expect(Pai.parse("s9t")!.next() == nil ).to.beTrue()
                expect(Pai.parse("s8t")!.next(range:2) == nil ).to.beTrue()
            }
        }
        describe("isNext"){
            it("returns true"){
                expect(Pai.parse("s1t")!.isNext(Pai.parse("s2t")!)).to.beTrue()
            }
            it("returns false"){
                expect(Pai.parse("s1t")!.isNext(Pai.parse("s9t")!)).to.beFalse()
                expect(Pai.parse("s1t")!.isNext(Pai.parse("j2t")!)).to.beFalse()
                expect(Pai.parse("j1t")!.isNext(Pai.parse("j2t")!)).to.beFalse()
                expect(Pai.parse("s9t")!.isNext(Pai.parse("s1t")!)).to.beFalse()
                expect(Pai.parse("r1t")!.isNext(Pai.parse("r2t")!)).to.beFalse()
            }
        }
        describe("prev"){
            it("returns prev pai"){
                expect(Pai.parse("s3t")!.prev()!.toString()).to.equal("s2t")
                expect(Pai.parse("s3t")!.prev(range:1)!.toString()).to.equal("s2t")
                expect(Pai.parse("s3t")!.prev(range:2)!.toString()).to.equal("s1t")
            }
            it("returns nil"){
                expect(Pai.parse("j1t")!.prev() == nil).to.beTrue()
                expect(Pai.parse("r1t")!.prev() == nil).to.beTrue()
                expect(Pai.parse("s1t")!.prev() == nil).to.beTrue()
                expect(Pai.parse("s2t")!.prev(range:2) == nil).to.beTrue()
            }
        }
        describe("isPrev"){
            it("returns true"){
                expect(Pai.parse("s2t")!.isPrev(Pai.parse("s1t")!)).to.beTrue()
            }
            it("returns false"){
                expect(Pai.parse("s9t")!.isPrev(Pai.parse("s1t")!)).to.beFalse()
                expect(Pai.parse("s2t")!.isPrev(Pai.parse("j1t")!)).to.beFalse()
                expect(Pai.parse("j2t")!.isPrev(Pai.parse("j1t")!)).to.beFalse()
                expect(Pai.parse("s1t")!.isPrev(Pai.parse("s9t")!)).to.beFalse()
                expect(Pai.parse("r2t")!.isPrev(Pai.parse("r1t")!)).to.beFalse()
            }
        }
    }
}

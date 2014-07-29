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
        describe("#parse") {
            it("parses the string which match with MJ protocol") {
                var pai:Pai = PaiMaster.pais["m1l"]!
                
                expect(pai.type == PaiType.MANZU).to(beTruthy())
                expect(pai.number).to(equal(1))
                expect(pai.direction == PaiDirection.LEFT).to(beTruthy())
                expect(pai.toString()).to(equal("m1l"))
            }
            
            it("returns nil when specified string does not match with MJ protocol") {
                if let pai = PaiMaster.pais["detarame"] {
                    // should not come to this place
                    expect(true).to(equal(false))
                } else {
                    // should come to this place
                    expect(true).to(equal(true))
                }
            }
        }
        describe("#parseList"){
            it("returns array of Pai"){
                let paiList:[Pai] = Pai.parseList("s2lm1tp5t")!
                expect(paiList[0].toString()).to(equal("s2l"))
                expect(paiList[1].toString()).to(equal("m1t"))
                expect(paiList[2].toString()).to(equal("p5t"))
            }
        }
        describe("Equatable"){
            it("return Bool"){
                let pai1 = PaiMaster.pais["s1l"]
                let pai2 = PaiMaster.pais["s1t"]
                let pai3 = PaiMaster.pais["s2l"]
                expect(pai1 == pai2).to(beTruthy())
                expect(pai1 == pai3).to(beFalsy())
                expect(pai1 === pai1).to(beTruthy())
                expect(pai1 === pai2).to(beFalsy())
            }
        }
        describe("<"){
            it("return true"){
                expect(PaiMaster.pais["s1t"] < PaiMaster.pais["s2t"]).to(beTruthy())
            }
            it("return false"){
                expect(PaiMaster.pais["s3t"] < PaiMaster.pais["s2t"]).to(beFalsy())
                expect(PaiMaster.pais["s3t"] < PaiMaster.pais["j2t"]).to(beFalsy())
            }
        }
        describe(">"){
            it("return true"){
                expect(PaiMaster.pais["s2t"] > PaiMaster.pais["s1t"]).to(beTruthy())
            }
            it("return false"){
                expect(PaiMaster.pais["s1t"] > PaiMaster.pais["s2t"]).to(beFalsy())
                expect(PaiMaster.pais["s3t"] > PaiMaster.pais["j2t"]).to(beFalsy())
            }
            it("shuld be sorted"){
                let paiList:[Pai] = Pai.parseList("m2tm1tm4t")!
                var sorted = paiList
                sort(&sorted,>)
                expect(sorted[0].toString()).to(equal("m4t"))
                expect(sorted[1].toString()).to(equal("m2t"))
                expect(sorted[2].toString()).to(equal("m1t"))
            }
        }
        describe("=="){
            it("return true"){
                expect(PaiMaster.pais["s2t"] == PaiMaster.pais["s2t"]).to(beTruthy())
            }
            it("return false"){
                expect(PaiMaster.pais["s1t"] == PaiMaster.pais["s2t"]).to(beFalsy())
            }
        }
        describe("!="){
            it("return true"){
                expect(PaiMaster.pais["s2t"] != PaiMaster.pais["s1t"]).to(beTruthy())
            }
            it("return false"){
                expect(PaiMaster.pais["s2t"] != PaiMaster.pais["s2t"]).to(beFalsy())
            }
        }
        describe("isShupai"){
            it("works"){
                expect(PaiMaster.pais["j1t"]!.isShupai).to(beFalsy())
                expect(PaiMaster.pais["m1t"]!.isShupai).to(beTruthy())
                expect(PaiMaster.pais["s1t"]!.isShupai).to(beTruthy())
                expect(PaiMaster.pais["p1t"]!.isShupai).to(beTruthy())
                expect(PaiMaster.pais["r0t"]!.isShupai).to(beFalsy())
            }
        }
        describe("isYaochu"){
            it("works"){
                expect(PaiMaster.pais["j2t"]!.isYaochu).to(beTruthy())
                expect(PaiMaster.pais["j1t"]!.isYaochu).to(beTruthy())
                expect(PaiMaster.pais["s1t"]!.isYaochu).to(beTruthy())
                expect(PaiMaster.pais["s9t"]!.isYaochu).to(beTruthy())
                expect(PaiMaster.pais["p1t"]!.isYaochu).to(beTruthy())
                expect(PaiMaster.pais["p9t"]!.isYaochu).to(beTruthy())
                expect(PaiMaster.pais["s2t"]!.isYaochu).to(beFalsy())
                expect(PaiMaster.pais["r0t"]!.isYaochu).to(beFalsy())
            }
        }
        describe("next"){
            it("returns next pai"){
                expect(PaiMaster.pais["s1t"]!.next()!.toString()).to(equal("s2t"))
                expect(PaiMaster.pais["s1t"]!.next(range:1)!.toString()).to(equal("s2t"))
                expect(PaiMaster.pais["s1t"]!.next(range: 2)!.toString()).to(equal("s3t"))
            }
            it("returns nil"){
                expect(PaiMaster.pais["j1t"]!.next() == nil ).to(beTruthy())
                expect(PaiMaster.pais["r0t"]!.next() == nil ).to(beTruthy())
                expect(PaiMaster.pais["s9t"]!.next() == nil ).to(beTruthy())
                expect(PaiMaster.pais["s8t"]!.next(range:2) == nil ).to(beTruthy())
            }
        }
        describe("isNext"){
            it("returns true"){
                expect(PaiMaster.pais["s1t"]!.isNext(PaiMaster.pais["s2t"]!)).to(beTruthy())
            }
            it("returns false"){
                expect(PaiMaster.pais["s1t"]!.isNext(PaiMaster.pais["s9t"]!)).to(beFalsy())
                expect(PaiMaster.pais["s1t"]!.isNext(PaiMaster.pais["j2t"]!)).to(beFalsy())
                expect(PaiMaster.pais["j1t"]!.isNext(PaiMaster.pais["j2t"]!)).to(beFalsy())
                expect(PaiMaster.pais["s9t"]!.isNext(PaiMaster.pais["s1t"]!)).to(beFalsy())
                expect(PaiMaster.pais["r0t"]!.isNext(PaiMaster.pais["r0t"]!)).to(beFalsy())
            }
        }
        describe("prev"){
            it("returns prev pai"){
                expect(PaiMaster.pais["s3t"]!.prev()!.toString()).to(equal("s2t"))
                expect(PaiMaster.pais["s3t"]!.prev(range:1)!.toString()).to(equal("s2t"))
                expect(PaiMaster.pais["s3t"]!.prev(range:2)!.toString()).to(equal("s1t"))
            }
            it("returns nil"){
                expect(PaiMaster.pais["j1t"]!.prev() == nil).to(beTruthy())
                expect(PaiMaster.pais["r0t"]!.prev() == nil).to(beTruthy())
                expect(PaiMaster.pais["s1t"]!.prev() == nil).to(beTruthy())
                expect(PaiMaster.pais["s2t"]!.prev(range:2) == nil).to(beTruthy())
            }
        }
        describe("isPrev"){
            it("returns true"){
                expect(PaiMaster.pais["s2t"]!.isPrev(PaiMaster.pais["s1t"]!)).to(beTruthy())
            }
            it("returns false"){
                expect(PaiMaster.pais["s9t"]!.isPrev(PaiMaster.pais["s1t"]!)).to(beFalsy())
                expect(PaiMaster.pais["s2t"]!.isPrev(PaiMaster.pais["j1t"]!)).to(beFalsy())
                expect(PaiMaster.pais["j2t"]!.isPrev(PaiMaster.pais["j1t"]!)).to(beFalsy())
                expect(PaiMaster.pais["s1t"]!.isPrev(PaiMaster.pais["s9t"]!)).to(beFalsy())
            }
        }
    }
}

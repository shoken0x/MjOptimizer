//
//  ViewUtilsSpec.swift
//  MjOptimizer
//
//  Created by Shoken Fujisaki on 6/19/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class ViewUtilsSpec: QuickSpec {
    override func spec() {
        let m1t = Pai(type:PaiType.MANZU, number: 1)
        let m9t = Pai(type:PaiType.MANZU, number: 9)
        let s1t = Pai(type:PaiType.SOUZU, number: 1)
        let s9t = Pai(type:PaiType.SOUZU, number: 9)
        let p1t = Pai(type:PaiType.PINZU, number: 1)
        let p9t = Pai(type:PaiType.PINZU, number: 9)
        let j1t = Pai(type:PaiType.JIHAI, number: 1)
        let j2t = Pai(type:PaiType.JIHAI, number: 2)
        let j3t = Pai(type:PaiType.JIHAI, number: 3)
        let j4t = Pai(type:PaiType.JIHAI, number: 4)
        let j5t = Pai(type:PaiType.JIHAI, number: 5)
        let j6t = Pai(type:PaiType.JIHAI, number: 6)
        let j7t = Pai(type:PaiType.JIHAI, number: 7)
        let paiList = [m1t,m9t,s1t,s9t,p1t,p9t,j1t,j2t,j3t,j4t,j5t,j6t,j7t]
        let strList = ["MJw1","MJw9","MJs1","MJs9","MJt1","MJt9","MJf1","MJf2","MJf3","MJf4","MJd1","MJd2","MJd3"]
        
        describe("convertStringListFromPaiList") {
            beforeEach { }
            it(" make tehai") {
                expect(ViewUtils.convertStringListFromPaiList(paiList)).to(equal(strList))
            }
        }
        describe("convertStringFromPai SUHAI") {
            beforeEach { }
            it("m1t shold be MJw1 as MANZU 1") {
                expect(ViewUtils.convertStringFromPai(m1t)).to(equal("MJw1"))
            }
            it("s1t shold be MJs1 as SOUZU 1") {
                expect(ViewUtils.convertStringFromPai(s1t)).to(equal("MJs1"))
            }
            it("p1t shold be MJt1 as PINZU 1") {
                expect(ViewUtils.convertStringFromPai(p1t)).to(equal("MJt1"))
            }
        }
        describe("convertStringFromPai JIHAI") {
            it("j1t shold be MJf1 as TON") {
                expect(ViewUtils.convertStringFromPai(j1t)).to(equal("MJf1"))
            }
            it("j5t shold be MJd1 as HAKU") {
                expect(ViewUtils.convertStringFromPai(j5t)).to(equal("MJd1"))
            }
            it("j6t shold be MJd2 as HATSU") {
                expect(ViewUtils.convertStringFromPai(j6t)).to(equal("MJd2"))
            }
            it("j7t shold be MJd3 as CHUN") {
                expect(ViewUtils.convertStringFromPai(j7t)).to(equal("MJd3"))
            }
        }
    }
}

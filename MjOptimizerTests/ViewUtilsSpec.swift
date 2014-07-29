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
        let m1t = PaiMaster.pais["m1t"]!
        let m9t = PaiMaster.pais["m9t"]!
        let s1t = PaiMaster.pais["s1t"]!
        let s9t = PaiMaster.pais["s9t"]!
        let p1t = PaiMaster.pais["p1t"]!
        let p9t = PaiMaster.pais["p9t"]!
        let j1t = PaiMaster.pais["j1t"]!
        let j2t = PaiMaster.pais["j2t"]!
        let j3t = PaiMaster.pais["j3t"]!
        let j4t = PaiMaster.pais["j4t"]!
        let j5t = PaiMaster.pais["j5t"]!
        let j6t = PaiMaster.pais["j6t"]!
        let j7t = PaiMaster.pais["j7t"]!
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

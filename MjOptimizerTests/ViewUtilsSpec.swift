//
//  ViewUtilsSpec.swift
//  MjOptimizer
//
//  Created by Shoken Fujisaki on 6/19/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick

class ViewUtilsSpec: QuickSpec {
    override func exampleGroups() {
        let m1t = Pai(type:PaiType.MANZU, number: 1)
        let s1t = Pai(type:PaiType.SOUZU, number: 1)
        let p1t = Pai(type:PaiType.PINZU, number: 1)
        let j1t = Pai(type:PaiType.JIHAI, number: 1)
        let j5t = Pai(type:PaiType.JIHAI, number: 5)
        let j6t = Pai(type:PaiType.JIHAI, number: 6)
        let j7t = Pai(type:PaiType.JIHAI, number: 7)
        
        describe("convertImageFromPai SUHAI") {
            beforeEach { }
            it("m1t shold be MJw1 as MANZU 1") {
                expect(ViewUtils.convertImageFromPai(m1t)).to.equal("MJw1")
            }
            it("s1t shold be MJs1 as SOUZU 1") {
                expect(ViewUtils.convertImageFromPai(s1t)).to.equal("MJs1")
            }
            it("p1t shold be MJt1 as PINZU 1") {
                expect(ViewUtils.convertImageFromPai(p1t)).to.equal("MJt1")
            }
        }
        describe("convertImageFromPai JIHAI") {
            it("j1t shold be MJf1 as TON") {
                expect(ViewUtils.convertImageFromPai(j1t)).to.equal("MJf1")
            }
            it("j5t shold be MJd1 as HAKU") {
                expect(ViewUtils.convertImageFromPai(j5t)).to.equal("MJd1")
            }
            it("j6t shold be MJd2 as HATSU") {
                expect(ViewUtils.convertImageFromPai(j6t)).to.equal("MJd2")
            }
            it("j7t shold be MJd3 as CHUN") {
                expect(ViewUtils.convertImageFromPai(j7t)).to.equal("MJd3")
            }
        }
    }
}

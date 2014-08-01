//
//  AgariSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/30.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class AgariSpec: QuickSpec {
    override func spec() {
        describe("isRyanmenMachi"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, mentsuList: mentsuList)
                expect(agari.isRyanmenMachi()).to(beTruthy())
            }
            it("return false"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("m3tm3tm3t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = PaiMaster.pais["m3t"]!
                let agari = Agari(tsumoPai: tsumoPai, mentsuList: mentsuList)
                expect(agari.isRyanmenMachi()).to(beFalsy())
            }
        }
        describe("replaceMenzenOneMentsu"){
            it("return true"){
                let tsumoPai = PaiMaster.pais["m2t"]!
                let oldMentsu = Mentsu.parseStr("m1tm2tm3t")!
                let newMentsu = Mentsu.parseStr("m1tm2tm3t")!
                newMentsu.tsumoPai = tsumoPai
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m9tm9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    oldMentsu,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let oldAgari = Agari(tsumoPai: tsumoPai,mentsuList: mentsuList)
                let newAgari = oldAgari.replaceMenzenOneMentsu(oldMentsu,newMentsu:newMentsu)
                expect(oldAgari.mentsuList[0].toString()).to(equal("トイツ:m9"))
                expect(oldAgari.mentsuList[1].toString()).to(equal("アンコウ:p1"))
                expect(oldAgari.mentsuList[2].toString()).to(equal("シュンツ:m1m2m3"))
                expect(oldAgari.mentsuList[3].toString()).to(equal("シュンツ:m1m2m3"))
                expect(oldAgari.mentsuList[4].toString()).to(equal("ポン:s2"))
                expect(newAgari.mentsuList[0].toString()).to(equal("トイツ:m9"))
                expect(newAgari.mentsuList[1].toString()).to(equal("アンコウ:p1"))
                expect(newAgari.mentsuList[2].toString()).to(equal("シュンツ:m1m2m3(ツモm2)"))
                expect(newAgari.mentsuList[3].toString()).to(equal("シュンツ:m1m2m3"))
                expect(newAgari.mentsuList[4].toString()).to(equal("ポン:s2"))
            }
        }
    }
}


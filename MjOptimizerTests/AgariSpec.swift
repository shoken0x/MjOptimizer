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
        describe("replaceMenzenOneMentsu"){
            it("return true"){
                let agariPai = PaiMaster.pais["m2t"]!
                let oldMentsu = Mentsu.parseStr("m1tm2tm3t")!
                let newMentsu = Mentsu.parseStr("m1tm2tm3t")!
                newMentsu.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m9tm9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    oldMentsu,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let oldAgari = Agari(mentsuList: mentsuList)
                let newAgari = oldAgari.replaceMenzenOneMentsu(oldMentsu,newMentsu:newMentsu)
                expect(oldAgari.mentsuList[0].toString()).to(equal("トイツ:m9"))
                expect(oldAgari.mentsuList[1].toString()).to(equal("アンコウ:p1"))
                expect(oldAgari.mentsuList[2].toString()).to(equal("シュンツ:m1m2m3"))
                expect(oldAgari.mentsuList[3].toString()).to(equal("シュンツ:m1m2m3"))
                expect(oldAgari.mentsuList[4].toString()).to(equal("ポン:s2"))
                expect(newAgari.mentsuList[0].toString()).to(equal("トイツ:m9"))
                expect(newAgari.mentsuList[1].toString()).to(equal("アンコウ:p1"))
                expect(newAgari.mentsuList[2].toString()).to(equal("シュンツ:m1m2m3(アガリ牌m2)"))
                expect(newAgari.mentsuList[3].toString()).to(equal("シュンツ:m1m2m3"))
                expect(newAgari.mentsuList[4].toString()).to(equal("ポン:s2"))
            }
        }
    }
}


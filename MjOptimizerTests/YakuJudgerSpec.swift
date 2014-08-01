//
//  YakuJudgerSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class YakuJudgerSpec: QuickSpec {
    override func spec() {
        describe("judge"){
            it("return tanyao"){
                let yakuJudger = YakuJudger()
                let agariPai = Pai.parse("m2t")!
                let atama = ToitsuMentsu(pai: Pai.parse("m2t")!)
                var mentsuList:[Mentsu] = []
                mentsuList.append(Mentsu.parseStr("m2tm3tm4t")!)
                mentsuList.append(Mentsu.parseStr("p2tp3tp4t")!)
                mentsuList.append(Mentsu.parseStr("s2ts3ts4t")!)
                mentsuList.append(Mentsu.parseStr("m2tm2t")!)
                mentsuList.append(Mentsu.parseStr("s2ts2ts2l")!)
                let agari = Agari(agariPai: agariPai, mentsuList: mentsuList)
                let kyoku = Kyoku()
                let yakuList:[Yaku] = yakuJudger.judge(agari,kyoku: kyoku)
                expect(yakuList.count).to(equal(1))
                expect(yakuList[0].kanji()).to(equal("断么九"))
            }
        }
    }
}

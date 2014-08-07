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
            it("returns タンピン三色"){
                let agariPai = PaiMaster.pais["m2t"]!
                var m = Mentsu.parseStr("m2tm3tm4t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("s2ts2t")!,
                    Mentsu.parseStr("s2ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp6tp5t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                let yakuList:[Yaku] = YakuJudger().judge(agari,kyoku:kyoku)
                expect(yakuList[0].kanji).to(equal("平和"))
                expect(yakuList[1].kanji).to(equal("断么九"))
                expect(yakuList[2].kanji).to(equal("三色同順"))
            }
            it("returns チンイツ・順チャン・リャンペいこう"){
                let agariPai = PaiMaster.pais["m1t"]!
                var m = Mentsu.parseStr("m1tm2tm3t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("m7tm8tm9t")!,
                    Mentsu.parseStr("m7tm8tm9t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                let yakuList:[Yaku] = YakuJudger().judge(agari,kyoku:kyoku)
                expect(yakuList[0].kanji).to(equal("平和"))
                expect(yakuList[1].kanji).to(equal("二盃口"))
                expect(yakuList[2].kanji).to(equal("純全帯么九"))
                expect(yakuList[3].kanji).to(equal("清一色"))
            }
        }
    }
}

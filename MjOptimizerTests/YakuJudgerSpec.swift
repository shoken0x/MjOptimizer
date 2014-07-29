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
                let tsumoPai = Pai.parse("m2t")!
                let atama = ToitsuMentsu(pai: Pai.parse("m2t")!)
                var menzenMentsuList:[Mentsu] = []
                var furoMentsuList:[Mentsu] = []
                menzenMentsuList.append(Mentsu.parseStr("m2tm3tm4t")!)
                menzenMentsuList.append(Mentsu.parseStr("p2tp3tp4t")!)
                menzenMentsuList.append(Mentsu.parseStr("s2ts3ts4t")!)
                menzenMentsuList.append(Mentsu.parseStr("m2tm2t")!)
                furoMentsuList.append(Mentsu.parseStr("s2ts2ts2l")!)
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                
                let yakuList:[Yaku] = yakuJudger.judge(agari)
                expect(yakuList.count).to(equal(1))
                expect(yakuList[0].kanji()).to(equal("断么九"))
            }
        }
    }
}
